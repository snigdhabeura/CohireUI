using Cohire.Models.CommonOperation;
using Cohire.Models.JobFeedListNM;
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
        public int? ProfileID { get; set; }
        public string CHProfileID { get; set; }
        public string FullName { get; set; }
        public string Email { get; set; }
        public string Mobile { get; set; }
        public string OTP { get; set; }
        public string Password { get; set; }
        public bool? Is_Email_Verified { get; set; }
        public bool? Is_Mobile_Verified { get; set; }
        public bool? Is_OTP_Verififed { get; set; }
        public string OTP_Message { get; set; }
        public string Ip_Address { get; set; }
        public string DeviceType { get; set; }
        public string Profile_Image { get; set; }
        public string Comment { get; set; }
        public string ChJobID { get; set; }
        public int Countofaction { get; set; }
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
                        connectionString = GetConnectionString.Instance.ReturnConnectionString();
                    }
                    return instance;
                }
            }
        }

        public async Task<string> UserRegistarionAsync(string CHProfileID, string FullName, string Email, string Mobile, string OTP, string Password,string OTP_Message,string Ip_Address,string DeviceType)
        {
            string Is_insert = string.Empty;
            SqlConnection azureSQLDb = null;
            using (azureSQLDb = new SqlConnection(connectionString))
            {
                if (azureSQLDb.State == System.Data.ConnectionState.Closed)
                    azureSQLDb.Open();
                SqlCommand cmd = new SqlCommand("dbo.Register_user_Profile", azureSQLDb);
                cmd.Parameters.Add("@CHProfileID", SqlDbType.VarChar).Value = CHProfileID;
                cmd.Parameters.Add("@FullName", SqlDbType.VarChar).Value = FullName;
                cmd.Parameters.Add("@Email", SqlDbType.VarChar).Value = !string.IsNullOrEmpty(Email)? Email:null;
                cmd.Parameters.Add("@Mobile", SqlDbType.VarChar).Value = !string.IsNullOrEmpty(Mobile) ? Mobile : null;
                cmd.Parameters.Add("@OTP", SqlDbType.VarChar).Value = OTP;
                cmd.Parameters.Add("@Password", SqlDbType.VarChar).Value =CommonOP.Instance.Encrypt(Password);
                cmd.Parameters.Add("@OTP_Message", SqlDbType.VarChar).Value = OTP_Message;
                cmd.Parameters.Add("@Ip_Address", SqlDbType.VarChar).Value = Ip_Address;
                cmd.Parameters.Add("@Device_Type", SqlDbType.VarChar).Value = DeviceType;
                cmd.CommandType = CommandType.StoredProcedure;
                Is_insert = cmd.ExecuteScalarAsync().GetAwaiter().GetResult().ToString();

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
                        cmd = new SqlCommand("dbo.Verify_user_Profile", azureSQLDb);
                        cmd.Parameters.Add("@CHProfileID", SqlDbType.VarChar).Value = CHProfileID;
                        cmd.Parameters.Add("@OTP", SqlDbType.VarChar).Value = OTP;
                        cmd.CommandType = CommandType.StoredProcedure;
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

        public async Task<SigupModel> Login(string email, string passwword,string mobile,string Ip_Address,string DeviceType)
        {
            SigupModel SigupModel = new SigupModel();
            try
            {
                passwword = CommonOP.Instance.Encrypt(passwword);
                SqlConnection azureSQLDb = null;
                SqlCommand cmd;
                using (azureSQLDb = new SqlConnection(connectionString))
                {
                    if (azureSQLDb.State == System.Data.ConnectionState.Closed)
                        azureSQLDb.Open();

                   
                    cmd = new SqlCommand("Authenticate_User", azureSQLDb);
                    cmd.Parameters.Add("@Email", SqlDbType.VarChar).Value = !string.IsNullOrEmpty(email) ? email : null;
                    cmd.Parameters.Add("@Mobile", SqlDbType.VarChar).Value = !string.IsNullOrEmpty(mobile) ? mobile : null;
                    cmd.Parameters.Add("@Ip_Address", SqlDbType.VarChar).Value = Ip_Address;
                    cmd.Parameters.Add("@Device_Type", SqlDbType.VarChar).Value = DeviceType;
                    cmd.Parameters.Add("@Password", SqlDbType.VarChar).Value =passwword;
                    cmd.CommandType = CommandType.StoredProcedure;
                    var Is_inserted = await cmd.ExecuteScalarAsync();
                    if(string.IsNullOrEmpty(Convert.ToString(Is_inserted)))
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

        public async Task<Sigupresponse>SendTempPassword(string email,string mobile)
        {
            Sigupresponse sigupresponse = new Sigupresponse();
            try
            {
                string paswword = CommonOP.Instance.RandomString();
                SqlConnection azureSQLDb = null;
                SqlCommand cmd;
                CommonOP commonOP = new CommonOP();
                using (azureSQLDb = new SqlConnection(connectionString))
                {
                    if (azureSQLDb.State == System.Data.ConnectionState.Closed)
                        azureSQLDb.Open();
                    cmd = new SqlCommand("dbo.SendTemporaryPassword", azureSQLDb);
                    cmd.Parameters.Add("@Email", SqlDbType.VarChar).Value = !string.IsNullOrEmpty(email) ? email : null;
                    cmd.Parameters.Add("@Mobile", SqlDbType.VarChar).Value = !string.IsNullOrEmpty(mobile) ? mobile : null;
                    cmd.Parameters.Add("@randomString ", SqlDbType.VarChar).Value =commonOP.Encrypt(paswword);
                    cmd.CommandType = CommandType.StoredProcedure;
                    var Is_inserted = await cmd.ExecuteScalarAsync();
                    sigupresponse.Is_error = false;
                    if (Is_inserted.ToString() == "0")
                    {
                        if (!string.IsNullOrEmpty(email))
                        { sigupresponse.Is_error = true;  sigupresponse.errormsg = "Given email not exist"; }
                        if (!string.IsNullOrEmpty(mobile))
                        { sigupresponse.Is_error = true;  sigupresponse.errormsg = "Given mobile number not exist"; }

                    }
                    else
                    {
                        if (!string.IsNullOrEmpty(email))
                        {

                            var response = commonOP.SendEmailGoDady(email, "SignupOTP", "Your new temporary password:  " + Is_inserted + "");
                            if (response != true)
                            {
                                sigupresponse.Is_error = true;
                                sigupresponse.errormsg = "password can't send to your email";
                            }
                            else
                            {
                                sigupresponse.errormsg = "password has been sent to your email";
                            }
                        }
                        else
                        {

                        }
                        if (!string.IsNullOrEmpty(mobile))
                        {

                            var response = commonOP.sendSMS("Your new temporary password:  " + Is_inserted + "", mobile);
                            if (response.status == "failure")
                            {
                                sigupresponse.Is_error = true;
                                sigupresponse.errormsg = "password can't send to your mobile";
                            }
                            else
                            {
                                sigupresponse.errormsg = "password has been sent to your mobile";
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {

                sigupresponse.Is_error = true;
                sigupresponse.errormsg = "Something went wrong";
            }
            return sigupresponse;
        }

        public async Task<SigupModel> SetCommentForPost(string ChJobID,string PostedBy_ID,string Comment)
        {
            SigupModel model = new SigupModel();
            try
            {
                JobFeedList jobFeedList = new JobFeedList();
                SqlConnection azureSQLDb = null;
                SqlCommand cmd;
                using (azureSQLDb = new SqlConnection(connectionString))
                {
                    if (azureSQLDb.State == System.Data.ConnectionState.Closed)
                        azureSQLDb.Open();
                    cmd = new SqlCommand("[dbo].[Get_Job_Post_Josn]", azureSQLDb);
                    cmd.Parameters.Add("@JobId", SqlDbType.VarChar).Value = ChJobID;
                    cmd.CommandType = CommandType.StoredProcedure;
                    var Is_Get = await cmd.ExecuteScalarAsync();
                    if (string.IsNullOrEmpty(Convert.ToString(Is_Get)))
                    {
                        model = null;
                    }
                    else
                    {
                       var JobActionModel = JsonConvert.DeserializeObject<JobActionModel>(Is_Get.ToString());
                        jobFeedList= JsonConvert.DeserializeObject<JobFeedList>(JobActionModel.JobJson.ToString());
                        int current_previouscount = (Convert.ToInt32(jobFeedList.commentCount) + 1);
                        jobFeedList.commentCount = current_previouscount.ToString();
                        var jobJson= JsonConvert.SerializeObject(jobFeedList);
                        cmd = new SqlCommand("UpdatePostJob", azureSQLDb);
                        cmd.Parameters.Add("@updateType", SqlDbType.VarChar).Value = 'c';
                        cmd.Parameters.Add("@JobJosn", SqlDbType.VarChar).Value = jobJson;
                        cmd.Parameters.Add("@CountOfAction", SqlDbType.VarChar).Value = current_previouscount.ToString();
                        cmd.Parameters.Add("@ProfileId", SqlDbType.VarChar).Value = PostedBy_ID;
                        cmd.Parameters.Add("@JobId", SqlDbType.VarChar).Value = ChJobID;
                        cmd.Parameters.Add("@comment", SqlDbType.VarChar).Value = Comment;
                        cmd.CommandType = CommandType.StoredProcedure;
                        var Is_updtaed = await cmd.ExecuteScalarAsync();
                        model= JsonConvert.DeserializeObject<SigupModel>(Is_updtaed.ToString());
                    }

                }
            }
            catch (Exception ex)
            {

                model = null;
            }
            return model;
        }
    }
}
