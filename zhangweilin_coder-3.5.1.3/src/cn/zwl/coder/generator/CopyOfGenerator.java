package cn.zwl.coder.generator;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.LineNumberReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.StringReader;
import java.io.StringWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import cn.zwl.coder.generator.util.FileUtil;
import cn.zwl.coder.generator.util.GLogger;
import cn.zwl.coder.generator.util.IOUtil;
import cn.zwl.coder.generator.util.StringUtil;
import freemarker.cache.FileTemplateLoader;
import freemarker.cache.MultiTemplateLoader;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

/**
 * 生成器对象
 * 
 * @author zhangweilin
 */
public class CopyOfGenerator
{ 
    private static final String GENERATOR_INSERT_LOCATION = GeneratorProperties.getRequiredProperty("generator_insert_location_name");
    // 支持多个模板目录，以集合的方式组装
    private List templateRootDirsList = new ArrayList();
    
    //输出根目录
    private String outRootDir;
    
    //是否忽略生成异常
    private boolean ignoreTemplateGenerateException = true;

    //生成的字符集编码
    String encoding = StringUtil.getString(GeneratorProperties.getProperty("encoding"),"UTF-8");

    public CopyOfGenerator()
    {
    }

    public void setTemplateRootDir(File templateRootDir)
    {
        setTemplateRootDirs(new File[] { templateRootDir });
    }

    public void setTemplateRootDirs(File[] templateRootDirs)
    {
        this.templateRootDirsList = Arrays.asList(templateRootDirs);
    }

    public void addTemplateRootDir(File f)
    {
        templateRootDirsList.add(f);
    }

    public boolean isIgnoreTemplateGenerateException()
    {
        return ignoreTemplateGenerateException;
    }

    public void setIgnoreTemplateGenerateException(boolean ignoreTemplateGenerateException)
    {
        this.ignoreTemplateGenerateException = ignoreTemplateGenerateException;
    }

    public String getEncoding()
    {
        return encoding;
    }

    public void setEncoding(String v)
    {
        if (v == null)
        {
            throw new IllegalArgumentException("encoding must be not null");
        }
        this.encoding = v;
    }

    public void setOutRootDir(String v)
    {
        if (v == null)
        {
            throw new IllegalArgumentException("outRootDir must be not null");
        }
        this.outRootDir = v;
    }

    /**
     * 生成器的生成入口,支持多个模板根目录
     * 
     * @param templateModel
     *            生成器模板可以引用的变量,包含配置文件全部信息和table对象
     * @param filePathModel
     *            文件路径可以引用的变量，包含配置文件全部信息和table里所有的键值对
     *            
     * @throws Exception
     */
    public List generateBy(Map templateModel, Map filePathModel) throws Exception
    {
        if (templateRootDirsList.size() == 0)
        {
            throw new IllegalStateException("'templateRootDirs' cannot empty");
        }

        List allExceptions = new ArrayList();
        for (int i = 0; i < this.templateRootDirsList.size(); i++)
        {
            File templateRootDir = (File) templateRootDirsList.get(i);
            List exceptions = generateBy(templateRootDir, templateModel,filePathModel);
            allExceptions.addAll(exceptions);
        }
        return allExceptions;
    }

    /**
     * 在此生成并写出文件,返回忽略掉的异常列表
     * @param templateRootDir  模板根目录
     * @param templateModel  模板模型
     * @param filePathModel  文件模型
     * @return
     * @throws Exception
     */
    private List<Exception> generateBy(File templateRootDir, Map templateModel,
            Map filePathModel) throws Exception
    {
        if (templateRootDir == null)
        {
            throw new IllegalStateException("'templateRootDir' must be not null");
        }
        System.out.println("-------------------load template from templateRootDir = '"+ templateRootDir.getAbsolutePath() + "'");

        //文件名列表，忽略了隐藏文件和指定要忽略的文件
        List templateFileList = new ArrayList();
        //得到templateRootDir下所有的文件，包括子目录下的文件
        FileUtil.listFiles(templateRootDir, templateFileList);

        //记录忽略掉的异常
        List exceptions = new ArrayList();
        //遍历所有的模板文件
        for (int i = 0; i < templateFileList.size(); i++)
        {
            File templateFile = (File) templateFileList.get(i);
            //相对于模板的相对路径
            String templateRelativePath = FileUtil.getRelativePath(templateRootDir, templateFile);
            //输出的相对路径,如果路径中有@符号，则只取@前面部分
            String outputFilePath = templateRelativePath;
            
            //目录和隐藏文件忽略
            if (templateFile.isDirectory() || templateFile.isHidden())
            {
                continue;
            }
            //忽略非法文件或不存在的文件
            if (templateRelativePath.trim().equals(""))
            {
                continue;
            }
            
            //*.include文件也跳过,*.include文件为生成描述文件
            if (templateFile.getName().toLowerCase().endsWith(".include"))
            {
                System.out.println("[skip]\t\t endsWith '.include' template:"+ templateRelativePath);
                continue;
            }
            
            //==============神马情况会出现@================
            int testExpressionIndex = -1;
//            System.out.println("templateRelativePath: "+templateRelativePath);
            if ((testExpressionIndex = templateRelativePath.indexOf('@')) != -1)
            {
                //@前半部分
                outputFilePath = templateRelativePath.substring(0,
                        testExpressionIndex);
                //@后半部分
                String testExpressionKey = templateRelativePath
                        .substring(testExpressionIndex + 1);
                //filePathModel里存放有Table里所有属性的健值对和整个属性文件
                Object expressionValue = filePathModel.get(testExpressionKey);
                if (expressionValue == null)
                {
                    System.err
                            .println("[not-generate] WARN: test expression is null by key:["
                                    + testExpressionKey
                                    + "] on template:["
                                    + templateRelativePath + "]");
                    continue;
                }
                if (!"true".equals(String.valueOf(expressionValue)))
                {
                    System.out.println("[not-generate]\t test expression '@"
                            + testExpressionKey + "' is false,template:"
                            + templateRelativePath);
                    continue;
                }
            }
          //==============?????================

            String targetFilename = null;
            try
            {
                //targetFilename为生成的文件名，因为文件名本身也是动态生成的，
                /*
                 * outputFilePath为读取自模板文件夹里的文件原名，
                 * targetFilename为读取模板文件名后生成的新的目标文件名
                 */
                targetFilename = getTargetFilename(filePathModel, outputFilePath);
//                System.out.println("targetFilename: "+targetFilename);
                //生成新的文件或者在已生成的文件中追加内容
                generateNewFileOrInsertIntoFile(templateModel, targetFilename, newFreeMarkerConfiguration(), templateRelativePath,
                        outputFilePath);
            }
            catch (Exception e)
            {
                if (ignoreTemplateGenerateException)
                {
                    GLogger.warn("iggnore generate error,template is:"
                            + templateRelativePath + " cause:" + e);
                    exceptions.add(e);
                }
                else
                {
                    throw new RuntimeException(
                            "generate oucur error,templateFile is:"
                                    + templateRelativePath + " => "
                                    + targetFilename, e);
                }
            }
        }
        return exceptions;
    }

    /**
     * freemarker生成的一些基础配置
     * @return
     * @throws IOException
     */
    private Configuration newFreeMarkerConfiguration() throws IOException
    {
        Configuration config = new Configuration();

        FileTemplateLoader[] templateLoaders = new FileTemplateLoader[templateRootDirsList
                .size()];
        for (int i = 0; i < templateRootDirsList.size(); i++)
        {
            templateLoaders[i] = new FileTemplateLoader(
                    (File) templateRootDirsList.get(i));
        }
        MultiTemplateLoader multiTemplateLoader = new MultiTemplateLoader(
                templateLoaders);

        config.setTemplateLoader(multiTemplateLoader);
        config.setNumberFormat("###############");
        config.setBooleanFormat("true,false");
        config.setDefaultEncoding(encoding);
        return config;
    }

    private void generateNewFileOrInsertIntoFile(Map templateModel,
            String targetFilename, Configuration config, String templateFile,
            String outputFilePath) throws Exception
    {
        Template template = config.getTemplate(templateFile);
        template.setOutputEncoding(encoding);

        //要输出的绝对路径
        File absoluteOutputFilePath = getAbsoluteOutputFilePath(targetFilename);
//        System.out.println("targetFilename: "+targetFilename);
//        System.out.println("absoluteOutputFilePath: "+absoluteOutputFilePath);
        
        //如果在文件中找到“generator-insert-location”，则返回true,表示此处后面能追加内容
        if (absoluteOutputFilePath.exists())
        {
            StringWriter newFileContentCollector = new StringWriter();
            //如果在文件中找到“generator-insert-location”，则返回true,表示此处后面能追加内容
            if (isFoundInsertLocation(template, templateModel,
                    absoluteOutputFilePath, newFileContentCollector))
            {
                System.out.println("[insert]\t generate content into:"
                        + targetFilename);
                IOUtil.saveFile(absoluteOutputFilePath,
                        newFileContentCollector.toString());
                return;
            }
        }

        System.out.println("[generate]\t template:" + templateFile + " to "
                + targetFilename);
        
        //上面是在现成的文件中追加文件，此处为生成新的文件
        saveNewOutputFileContent(template, templateModel,
                absoluteOutputFilePath);
    }

    /**
     * 使用freemarker准备生成,注意，此只是让freemarker加载了模板数据（Map）,只动态生成文件名,但是并还没有保存成文件
     * @param filePathModel
     * @param templateFilepath
     * @return  返回生成的文件名，路径为相对路径
     * @throws Exception
     */
    private String getTargetFilename(Map filePathModel, String templateFilepath)
            throws Exception
    {
        StringWriter out = new StringWriter();
        Template template = new Template("filePath", new StringReader(
                templateFilepath), newFreeMarkerConfiguration());
        try
        {
            template.process(filePathModel, out);
            return out.toString();
        }
        catch (Exception e)
        {
            throw new IllegalStateException(
                    "cannot generate filePath from templateFilepath:"
                            + templateFilepath + " cause:" + e, e);
        }
    }

    /**
     * 根据要输出的文件的相对路径得到要输出的绝对路径
     * @param targetFilename
     * @return
     */
    private File getAbsoluteOutputFilePath(String targetFilename)
    {
        String outRoot = getOutRootDir();
        File outputFile = new File(outRoot, targetFilename);
        outputFile.getParentFile().mkdirs();
        return outputFile;
    }

    /**
     * 如果在文件中找到“generator-insert-location”，则返回true,表示此处后面能追加内容
     * @param template
     * @param templateModel
     * @param outputFile
     * @param newFileContent
     * @return
     * @throws IOException
     * @throws TemplateException
     */
    private boolean isFoundInsertLocation(Template template, Map templateModel,
            File outputFile, StringWriter newFileContent) throws IOException,
            TemplateException
    {
        LineNumberReader reader = new LineNumberReader(new FileReader(
                outputFile));
        String line = null;
        boolean isFoundInsertLocation = false;

        PrintWriter writer = new PrintWriter(newFileContent);
//        Writer writer=new BufferedWriter(newFileContent);
        while ((line = reader.readLine()) != null)
        {
//            System.out.println("outputFile: "+outputFile.exists());
//            System.out.println("line:  "+line);
            //先把目标文件里的内容读入到writer,然后一次性输出
            writer.println(line);
//            writer.write(line);
            // only insert once
            //如果找到可添加的标志，则添加一次 
            if (!isFoundInsertLocation
                    && line.indexOf(GENERATOR_INSERT_LOCATION) >= 0)
            {
//                System.out.println("templateModel: "+templateModel);
                template.process(templateModel, writer);
                writer.println();
//                System.out.println("找到标志: "+GENERATOR_INSERT_LOCATION);
//                writer.write(line);
                isFoundInsertLocation = true;
            }
        }

        writer.close();
        reader.close();
        return isFoundInsertLocation;
    }

    /**
     * 生成文件内容
     * @param template
     * @param model
     * @param outputFile
     * @throws IOException
     * @throws TemplateException
     */
    private void saveNewOutputFileContent(Template template, Map model,
            File outputFile) throws IOException, TemplateException
    {
        Writer out = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream(outputFile), encoding));
        template.process(model, out);
        out.close();
    }

    public void clean() throws IOException
    {
        String outRoot = getOutRootDir();
        File file=new File(outRoot);
        if (file.exists())
        {
            System.out.println("[Delete Dir]	" + outRoot);
//            FileUtil.deleteDirectory(file);
        }
    }

    private String getOutRootDir()
    {
        if (outRootDir == null)
            throw new IllegalStateException(
                    "'outRootDir' property must be not null.");
        return outRootDir;
    }

}
