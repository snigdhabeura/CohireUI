using System.Data;
using System;
using System.Data.SqlClient;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CohireAPI.PostJobs.Model;
using Cohire.Models.CommonOperation;

namespace Cohire.Model.PostJob
{
    public sealed class PostJobDB
    {
        private static PostJobDB instance = null;
        private static readonly object padlock = new object();
        private static string connectionString = string.Empty;
        public static PostJobDB Instance
        {
            get
            {
                lock (padlock)
                {
                    if (instance == null)
                    {
                        instance = new PostJobDB();
                        connectionString = GetConnectionString.Instance.ReturnConnectionString();
                    }
                    return instance;
                }
            }
        }
        public async Task<string> CreateJobPublic(ViewPostJobModel viewPostJobModel,string JobJson,string SearchInstance,string city)
        {
            SqlConnection azureSQLDb = null;
            try
            {
                
                using (azureSQLDb = new SqlConnection(connectionString))
                {
                    if (azureSQLDb.State == System.Data.ConnectionState.Closed)
                        azureSQLDb.Open();
                    SqlCommand cmd = new SqlCommand("[dbo].[CreateJobForPublic]", azureSQLDb);
                    cmd.Parameters.Add("@CategoryId", SqlDbType.Int).Value = viewPostJobModel.CategoryID;
                    cmd.Parameters.Add("@EmploymentId", SqlDbType.Int).Value = viewPostJobModel.EmploymenttypeID;
                    cmd.Parameters.Add("@ExperineceId", SqlDbType.Int).Value = viewPostJobModel.ExperienceID;
                    cmd.Parameters.Add("@JobID", SqlDbType.VarChar).Value = viewPostJobModel.JobId.ToString();
                    cmd.Parameters.Add("@ChJobID", SqlDbType.VarChar).Value = viewPostJobModel.ChJobID;
                    cmd.Parameters.Add("@PostedByID", SqlDbType.VarChar).Value = viewPostJobModel.PostedByID;
                    cmd.Parameters.Add("@JobJson", SqlDbType.VarChar).Value = JobJson;
                    cmd.Parameters.Add("@SearchInstance", SqlDbType.VarChar).Value = SearchInstance;
                    cmd.Parameters.Add("@city", SqlDbType.VarChar).Value = city;
                    cmd.Parameters.Add("@Is_Job", SqlDbType.Int).Value = viewPostJobModel.Is_Job;
                    cmd.Parameters.Add("@Ip_Address", SqlDbType.VarChar).Value =CommonOP.Instance.GetUserIP() ;
                    cmd.Parameters.Add("@Device_Type", SqlDbType.VarChar).Value = "D";
                    cmd.CommandType = CommandType.StoredProcedure;
                    var Is_inserted=await cmd.ExecuteNonQueryAsync();
                    return Is_inserted.ToString();
                }
            }
            catch (Exception ex)
            {

                return "";
            }
            finally
            {
                azureSQLDb.Close();
            }

        }

        public async Task<string> UpdateJobPublic(string ChJobID, string JobJson, string SearchInstance,string Ip_Address,string Device_Type,int Is_job,string PostedByID)
        {
            SqlConnection azureSQLDb = null;
            try
            {
                using (azureSQLDb = new SqlConnection(connectionString))
                {
                    if (azureSQLDb.State == System.Data.ConnectionState.Closed)
                        azureSQLDb.Open();
                    SqlCommand cmd = new SqlCommand("[dbo].[UpdateJobForPublic]", azureSQLDb);
                    cmd.Parameters.Add("@ChJobID", SqlDbType.VarChar).Value = ChJobID;
                    cmd.Parameters.Add("@JobJson", SqlDbType.VarChar).Value = JobJson;
                    cmd.Parameters.Add("@SearchInstance", SqlDbType.VarChar).Value = SearchInstance;
                    cmd.Parameters.Add("@Ip_Address", SqlDbType.VarChar).Value = Ip_Address;
                    cmd.Parameters.Add("@Device_Type", SqlDbType.VarChar).Value = Device_Type;
                    cmd.Parameters.Add("@Is_Job", SqlDbType.Int).Value = Is_job;
                    cmd.Parameters.Add("@PostedByID", SqlDbType.VarChar).Value = PostedByID;
                    cmd.CommandType = CommandType.StoredProcedure;
                    var Is_updated = await cmd.ExecuteNonQueryAsync();
                    return Is_updated.ToString();

                }
            }
            catch (Exception ex)
            {

                return "";
            }
            finally
            {
                azureSQLDb.Close();
            }
        }
    
        public async Task <List<string>> GetSkills()
        {
            SqlConnection azureSQLDb=null;
            List<string> data=null;
            try
            {
                
                    using (azureSQLDb = new SqlConnection(connectionString))
                    {
                        if (azureSQLDb.State == System.Data.ConnectionState.Closed)
                            azureSQLDb.Open();
                        SqlCommand cmd = new SqlCommand("Select SkillName from [dbo].[Skill_Master]", azureSQLDb);
                        var skilldata = await cmd.ExecuteScalarAsync();
                        data = JsonConvert.DeserializeObject<List<string>>(skilldata.ToString());
                        //data = data.Where(x=> x.Contains(skill,StringComparison.OrdinalIgnoreCase)).ToList();
                    }
                
                return data;
            }
            catch (Exception ex)
            {
                throw;
            }
            finally { azureSQLDb.Close(); }
        }
        public async Task<List<string>> GetQuestion()
        {
            SqlConnection azureSQLDb = null;
            List<string> data = null;
            try
            {
                
                using (azureSQLDb = new SqlConnection(connectionString))
                {
                    if (azureSQLDb.State == System.Data.ConnectionState.Closed)
                        azureSQLDb.Open();
                    SqlCommand cmd = new SqlCommand("SELECT Question = '['+STUFF(( SELECT ',\"' + Question + '\"'FROM [dbo].[Question_Master]  FOR XML PATH('') ), 1, 1,'')+']'", azureSQLDb);
                    var skilldata = await cmd.ExecuteScalarAsync();
                    data = JsonConvert.DeserializeObject<List<string>>(skilldata.ToString());
                }
                return data;
            }
            catch (Exception ex)
            {
                throw;
            }
            finally { azureSQLDb.Close(); }
        }

        public async Task<List<string>> GetCity()
        {
            SqlConnection azureSQLDb = null;
            List<string> data = null;
            try
            {

                using (azureSQLDb = new SqlConnection(connectionString))
                {
                    if (azureSQLDb.State == System.Data.ConnectionState.Closed)
                        azureSQLDb.Open();
                    SqlCommand cmd = new SqlCommand("Select [CityName] from [dbo].[City_Master]", azureSQLDb);
                    var CityData = await cmd.ExecuteScalarAsync();
                    data = JsonConvert.DeserializeObject<List<string>>(CityData.ToString());
                    //data = data.Where(x=> x.Contains(skill,StringComparison.OrdinalIgnoreCase)).ToList();
                }

                return data;
            }
            catch (Exception ex)
            {
                throw;
            }
            finally { azureSQLDb.Close(); }
        }


    }
}
