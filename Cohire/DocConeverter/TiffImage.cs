using SelectPdf;
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
    public class TiffImage
    {
        private string myPath;
        private Guid myGuid;
        private FrameDimension myDimension;
        public ArrayList myImages = new ArrayList();
        private int myPageCount;
        private Bitmap myBMP;

        public int convertPdfToImage(string path,string outputpath)
        {
            // the test file
            string filePdf = path;

            // settings
            string imgFormat = "PNG";

            int startPage = 1;
            int endPage = 0;
            // instantiate a pdf rasterizer (pdf to image converter) object
            PdfRasterizer rasterizer = new PdfRasterizer();

            // load PDF file
            rasterizer.Load(filePdf);

            // set the properties
            rasterizer.StartPageNumber = startPage;
            rasterizer.EndPageNumber = endPage;

            // other properties that can be set
            rasterizer.Resolution = 150;
          
            rasterizer.ColorSpace = PdfRasterizerColorSpace.RGB;
                // the other image formats (PNG, JPG, BMP)
                System.Drawing.Image[] images = rasterizer.ConvertToImages();
                int count = 0;
                images.ToList().ForEach(x => 
                {
                    count++;
                    x.Save(outputpath+"/Page-" + count + ".png", ImageFormat.Png);
                });
            return count;

        }

        private byte[] GetImageBytes(System.Drawing.Image image,
            System.Drawing.Imaging.ImageFormat format)
        {
            using (var ms = new System.IO.MemoryStream())
            {
                image.Save(ms, format);
                return ms.ToArray();
            }
        }

    }
}
