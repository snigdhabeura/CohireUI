using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Net.Mail;
using System.Reflection;
using System.Security.Cryptography;
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

        private static CommonOP instance = null;
        private static readonly object padlock = new object();

        public static CommonOP Instance
        {
            get
            {
                lock (padlock)
                {
                    if (instance == null)
                    {
                        instance = new CommonOP();
                    }
                    return instance;
                }
            }
        }
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
        public bool SendEmailGoDady(string toemail, string subject, string body)
        {
            try
            {
                MailMessage mail = new MailMessage("no-reply@cohyre.com", toemail);
                mail.Subject = subject;
                mail.IsBodyHtml = true;
                mail.Body = body;
                SmtpClient client = new SmtpClient("smtpout.asia.secureserver.net");
                client.DeliveryMethod = SmtpDeliveryMethod.Network;
                client.UseDefaultCredentials = false;
                client.Credentials = new System.Net.NetworkCredential("no-reply@cohyre.com", "M@ster007");
                client.Port = 80;
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


        public List<T> ConvertDataTable<T>(DataTable dt)
        {
            List<T> data = new List<T>();
            foreach (DataRow row in dt.Rows)
            {
                T item = GetItem<T>(row);
                data.Add(item);
            }
            return data;
        }
        private static T GetItem<T>(DataRow dr)
        {
            Type temp = typeof(T);
            T obj = Activator.CreateInstance<T>();

            foreach (DataColumn column in dr.Table.Columns)
            {
                foreach (PropertyInfo pro in temp.GetProperties())
                {
                    if (pro.Name == column.ColumnName)
                        pro.SetValue(obj, dr[column.ColumnName], null);
                    else
                        continue;
                }
            }
            return obj;
        }

        public string Encrypt(string clearText)
        {
            string EncryptionKey = "MAKV2SPBNI99212";
            byte[] clearBytes = Encoding.Unicode.GetBytes(clearText);
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (MemoryStream ms = new MemoryStream())
                {
                    using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                    {
                        cs.Write(clearBytes, 0, clearBytes.Length);
                        cs.Close();
                    }
                    clearText = Convert.ToBase64String(ms.ToArray());
                }
            }
            return clearText;
        }

        public string RandomString()
        {
            int size = 6;
            StringBuilder builder = new StringBuilder();
            Random random = new Random();
            char ch;
            for (int i = 0; i < size; i++)
            {
                ch = Convert.ToChar(Convert.ToInt32(Math.Floor(26 * random.NextDouble() + 65)));
                builder.Append(ch);
            }
            return builder.ToString();
        }

        public string GetUserIP()
        {
            string dataObjects = "Test";
            //HttpClient client = new HttpClient();
            //client.BaseAddress = new Uri("https://ipinfo.io/");
            //string urlParameters = "?token=c74e2bd432e4f1";
            //// Add an Accept header for JSON format.
            //client.DefaultRequestHeaders.Accept.Add(
            //new MediaTypeWithQualityHeaderValue("application/json"));

            //// List data response.
            //HttpResponseMessage response = client.GetAsync(urlParameters).Result;
            //if (response.IsSuccessStatusCode)
            //{
            //    // Parse the response body.
            //    dataObjects = response.Content.ReadAsStringAsync().Result;  //Make sure to add a reference to System.Net.Http.Formatting.dll  
            //}
            return dataObjects;
        }
    }
    public class GetConnectionString
    {
        private static GetConnectionString instance = null;
        private static readonly object padlock = new object();
        
        public static GetConnectionString Instance
        {
            get
            {
                lock (padlock)
                {
                    if (instance == null)
                    {
                        instance = new GetConnectionString();
                    }
                    return instance;
                }
            }
        }

        public string ReturnConnectionString()
        {
            string connectionstring = string.Empty;
            string username = "";
            string password = "";
            string Server = ".";
            string dataBase = "Cohire";
            if(!string.IsNullOrEmpty(username))
            {
                connectionstring = "Server=" + Server + ";Database=" + dataBase + ";User ID="+ username + ";Password="+ password + ";MultipleActiveResultSets=true;";
            }
            else
            {
                connectionstring = "Server=" + Server + ";Database=" + dataBase + ";Integrated Security=true;MultipleActiveResultSets=true;";
            }
            return connectionstring;
        }
    }
}
