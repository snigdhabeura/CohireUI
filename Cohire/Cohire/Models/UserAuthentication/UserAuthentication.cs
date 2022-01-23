using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace Cohire.Models.UserAuthentication
{
    public class SigupModel
    {
        public int ProfileID { get; set; }
        public string CHProfileID { get; set; }
        public string FullName { get; set; }
        public string Email { get; set; }
        public string Mobile { get; set; }
        public string OTP { get; set; }
        public string Password { get; set; }
        public bool Is_Email_Verified { get; set; }
        public bool Is_Mobile_Verified { get; set; }
        public bool Is_OTP_Verififed { get; set; }
        public string OTP_Message { get; set; }
    }
    public class Sigupresponse
    {
        public bool Is_error { get; set; }
        public string id { get; set; }
        public string errormsg { get; set; }
        public string ProfileID { get; set; }
    }

    public class UserAuthentication
    {
        private static UserAuthentication instance = null;
        private static readonly object padlock = new object();
        private static string connectionString = string.Empty;
        public static UserAuthentication Instance
        {
            get
            {
                lock (padlock)
                {
                    if (instance == null)
                    {
                        instance = new UserAuthentication();
                        connectionString = "Server=.;Database=Cohire;Integrated Security=true;MultipleActiveResultSets=true;";
                    }
                    return instance;
                }
            }
        }

        public async Task<string> UserRegistarionAsync(string CHProfileID, string FullName, string Email, string Mobile, string OTP, string Password,string OTP_Message)
        {
            string Is_insert = string.Empty;
            SqlConnection azureSQLDb = null;
            using (azureSQLDb = new SqlConnection(connectionString))
            {
                if (azureSQLDb.State == System.Data.ConnectionState.Closed)
                    azureSQLDb.Open();
                SqlCommand cmd = new SqlCommand("insert into dbo.User_Authentication (CHProfileID,FullName,Email,Mobile,OTP,Password,OTP_Message)values('" + CHProfileID+ "','" + FullName + "','" + Email + "','" + Mobile + "','" + OTP + "','" + Password + "','"+ OTP_Message + "')", azureSQLDb);
                Is_insert = (string)await cmd.ExecuteScalarAsync();
                
            }
            return Is_insert;
        }

        public async Task<SigupModel> ResendOTPAsync(string CHProfileID,string OTP)
        {
            SigupModel SigupModel = new SigupModel();
            try
            {
                SqlConnection azureSQLDb = null;
                SqlCommand cmd;
                using (azureSQLDb = new SqlConnection(connectionString))
                {
                    if (azureSQLDb.State == System.Data.ConnectionState.Closed)
                        azureSQLDb.Open();
                    if (string.IsNullOrEmpty(OTP))
                    {
                        cmd = new SqlCommand("select * from User_Authentication where CHProfileID='" + CHProfileID + "' FOR JSON AUTO", azureSQLDb);

                    }
                    else
                    {
                        cmd = new SqlCommand("select * from User_Authentication where CHProfileID='" + CHProfileID + "' and OTP='" + OTP + "' FOR JSON AUTO", azureSQLDb);
                    }
                    var Is_inserted = await cmd.ExecuteScalarAsync();
                    if(Is_inserted==null)
                    {
                        SigupModel = null;
                    }
                    else
                    {
                        SigupModel = JsonConvert.DeserializeObject<List<SigupModel>>(Is_inserted.ToString()).FirstOrDefault();
                    }

                }
            }
            catch (Exception ex)
            {

                SigupModel = null;
            }
            return SigupModel;
        }

        public async Task<SigupModel> Login(string email, string passwword)
        {
            SigupModel SigupModel = new SigupModel();
            try
            {
                SqlConnection azureSQLDb = null;
                SqlCommand cmd;
                using (azureSQLDb = new SqlConnection(connectionString))
                {
                    if (azureSQLDb.State == System.Data.ConnectionState.Closed)
                        azureSQLDb.Open();
                   
                        cmd = new SqlCommand("select * from User_Authentication where Password='" + passwword + "' and Email='" + email + "' FOR JSON AUTO", azureSQLDb);
                    
                    var Is_inserted = await cmd.ExecuteScalarAsync();
                    SigupModel = JsonConvert.DeserializeObject<List<SigupModel>>(Is_inserted.ToString()).FirstOrDefault();

                }
            }
            catch (Exception ex)
            {

                SigupModel = null;
            }
            return SigupModel;
        }
    }
}
