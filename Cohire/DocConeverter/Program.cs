using System;
using System.Collections;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DocConeverter
{
    public class Program
    {
        static void Main(string[] args)
        {
            
        }

        public int GetDocumentImage(string filepath, string outputpath, string filename)
        {
            int pagecount = 0;
            try
            {
                var docPath = filepath;
                var fileextensi = filename.Split('.')[1];
                string imageFilesFolder = Path.Combine(outputpath, Path.GetFileName(filename).Replace(".", "_"));
                if (!Directory.Exists(imageFilesFolder))
                {
                    Directory.CreateDirectory(imageFilesFolder);
                }
                if (fileextensi == "doc"|| fileextensi == "docx")
                {
                    var app = new Microsoft.Office.Interop.Word.Application();
                    var doc = app.Documents.Open(docPath);
                    doc.ShowGrammaticalErrors = false;
                    doc.ShowRevisions = false;
                    doc.ShowSpellingErrors = false;
                    foreach (Microsoft.Office.Interop.Word.Window window in doc.Windows)
                    {
                        foreach (Microsoft.Office.Interop.Word.Pane pane in window.Panes)
                        {
                            pagecount = pane.Pages.Count;
                            for (var i = 1; i <= pane.Pages.Count; i++)
                            {
                                var page = pane.Pages[i];
                                var bits = page.EnhMetaFileBits;
                                var target = Path.Combine(imageFilesFolder, string.Format($"page-{i}", i));

                                try
                                {
                                    using (var ms = new MemoryStream((byte[])(bits)))
                                    {
                                        var image = System.Drawing.Image.FromStream(ms);
                                        var pngTarget = Path.ChangeExtension(target, "png");
                                        image.Save(pngTarget, ImageFormat.Png);
                                    }
                                }
                                catch (System.Exception ex)
                                { }
                            }
                        }
                    }
                    doc.Close(Type.Missing, Type.Missing, Type.Missing);
                    app.Quit(Type.Missing, Type.Missing, Type.Missing);
                }
                else
                {
                    MemoryStream ms; Bitmap myBMP;
                    Guid myGuid;
                    Image myImage; FrameDimension myDimension;
                    ArrayList myImages = new ArrayList();
                    FileStream fs = new FileStream(filepath, FileMode.Open);
                    myImage = Image.FromStream(fs);
                    myGuid = myImage.FrameDimensionsList[0];
                    myDimension = new FrameDimension(myGuid);
                    pagecount = myImage.GetFrameCount(myDimension);
                    for (int i = 0; i < pagecount; i++)
                    {
                        var target = Path.Combine(imageFilesFolder, string.Format($"page-{i+1}", i));
                        ms = new MemoryStream();
                        myImage.SelectActiveFrame(myDimension, i);
                        myImage.Save(ms, ImageFormat.Bmp);
                        myBMP = new Bitmap(ms);
                        myImages.Add(myBMP);
                        ms.Close();
                    }
                    fs.Close();
                }
                
            }
            catch (Exception ex)
            {

                throw;
            }
            return pagecount;
        }
    }
}
