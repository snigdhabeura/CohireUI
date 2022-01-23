using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace Cohire.Models.CommonOperation
{
    public class Error
    {
        public int code { get; set; }
        public string message { get; set; }
    }

    public class SMSRoot
    {
        public List<Error> errors { get; set; }
        public string status { get; set; }
    }
    public class CommonOP
    {


       public bool SendEmail(string toemail,string subject,string body)
       {

        System.Net.Mail.MailMessage mail = new System.Net.Mail.MailMessage();
        mail.To.Add(toemail);
        mail.From = new MailAddress("animponima@gmail.com", "animponima@gmail.com", System.Text.Encoding.UTF8);
        mail.Subject = subject;
        mail.SubjectEncoding = System.Text.Encoding.UTF8;
        mail.Body = body;
        mail.BodyEncoding = System.Text.Encoding.UTF8;
        mail.IsBodyHtml = true;
        mail.Priority = MailPriority.High;
        SmtpClient client = new SmtpClient();
        client.Credentials = new System.Net.NetworkCredential("animponima@gmail.com", "Pulsar@220");
        client.Port = 587;
        client.Host = "smtp.gmail.com";
        client.EnableSsl = true;
        try
        {
            client.Send(mail);
                return true;
        }
        catch (Exception ex)
        {
                return false;
        }
    }

        public SMSRoot sendSMS(string msg,string MobileNumber)
        {
            SMSRoot sMSRoot = new SMSRoot();
               String result;
            string apiKey = "Mzc3MDQ0NGI0OTYzNjQ3OTRkNzQ1NTYxNTY1NTQyMzU=";
            string numbers = MobileNumber; // in a comma seperated list
            string message = msg;
            string sender = "Cohyre";

            String url = "https://api.textlocal.in/send/?apikey=" + apiKey + "&numbers=" + numbers + "&message=" + message + "&sender=" + sender;
            //refer to parameters to complete correct url string

            StreamWriter myWriter = null;
            HttpWebRequest objRequest = (HttpWebRequest)WebRequest.Create(url);

            objRequest.Method = "POST";
            objRequest.ContentLength = Encoding.UTF8.GetByteCount(url);
            objRequest.ContentType = "application/x-www-form-urlencoded";
            try
            {
                myWriter = new StreamWriter(objRequest.GetRequestStream());
                myWriter.Write(url);
            }
            catch (Exception e)
            {
                sMSRoot.status = "failure";
                return sMSRoot;
            }
            finally
            {
                myWriter.Close();
            }

            HttpWebResponse objResponse = (HttpWebResponse)objRequest.GetResponse();
            using (StreamReader sr = new StreamReader(objResponse.GetResponseStream()))
            {
                result = sr.ReadToEnd();
                sMSRoot= JsonConvert.DeserializeObject<SMSRoot>(result);
                sr.Close();
            }
            return sMSRoot;
           
        }
    }
}
