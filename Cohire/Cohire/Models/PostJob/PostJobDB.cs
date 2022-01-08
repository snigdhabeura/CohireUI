using System.Data;
using System;
using System.Data.SqlClient;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

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
                        connectionString= "Server=.;Database=Cohire;Integrated Security=true;MultipleActiveResultSets=true;";
                    }
                    return instance;
                }
            }
        }
        public async Task<string> CreateJobPublic(string JobID, string ChJobID, string PostedByID, string JobJson, string SearchInstance)
        {
            SqlConnection azureSQLDb = null;
            try
            {
                
                using (azureSQLDb = new SqlConnection(connectionString))
                {
                    if (azureSQLDb.State == System.Data.ConnectionState.Closed)
                        azureSQLDb.Open();
                    SqlCommand cmd = new SqlCommand("[dbo].[CreateJobForPublic]", azureSQLDb);
                    cmd.Parameters.Add("@JobID", SqlDbType.VarChar).Value = JobID;
                    cmd.Parameters.Add("@ChJobID", SqlDbType.VarChar).Value = ChJobID;
                    cmd.Parameters.Add("@PostedByID", SqlDbType.VarChar).Value = PostedByID;
                    cmd.Parameters.Add("@JobJson", SqlDbType.VarChar).Value = JobJson;
                    cmd.Parameters.Add("@SearchInstance", SqlDbType.VarChar).Value = SearchInstance;
                    cmd.CommandType = CommandType.StoredProcedure;
                    var Is_inserted=await cmd.ExecuteNonQueryAsync();
                    return Is_inserted.ToString();
                }
            }
            catch (Exception ex)
            {

                return ex.Message + "||" + ex.StackTrace;
            }
            finally
            {
                azureSQLDb.Close();
            }

        }

        public async Task<string> UpdateJobPublic(string ChJobID, string JobJson, string SearchInstance)
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
                    cmd.CommandType = CommandType.StoredProcedure;
                    var Is_updated = await cmd.ExecuteNonQueryAsync();
                    return Is_updated.ToString();

                }
            }
            catch (Exception ex)
            {

                return ex.Message + "||" + ex.StackTrace;
            }
            finally
            {
                azureSQLDb.Close();
            }
        }
    
        public async Task <List<string>> GetSkills(string skill)
        {
            SqlConnection azureSQLDb=null;
            List<string> data=null;
            try
            {
                if (!string.IsNullOrEmpty(skill))
                {
                    using (azureSQLDb = new SqlConnection(connectionString))
                    {
                        if (azureSQLDb.State == System.Data.ConnectionState.Closed)
                            azureSQLDb.Open();
                        SqlCommand cmd = new SqlCommand("Select SkillName from [dbo].[Skill_Master]", azureSQLDb);
                        var skilldata = await cmd.ExecuteScalarAsync();
                        data = JsonConvert.DeserializeObject<List<string>>(skilldata.ToString());
                        data = data.Where(x=> x.Contains(skill,StringComparison.OrdinalIgnoreCase)).ToList();
                    }
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
                    SqlCommand cmd = new SqlCommand("Select Question from [dbo].[Question_Master]", azureSQLDb);
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
        public async Task<List<string>> GetRolls()
        {
            SqlConnection azureSQLDb = null;
            List<string> data = null;
            try
            {
                if (!string.IsNullOrEmpty(skill))
                {
                    using (azureSQLDb = new SqlConnection(connectionString))
                    {
                        if (azureSQLDb.State == System.Data.ConnectionState.Closed)
                            azureSQLDb.Open();
                        SqlCommand cmd = new SqlCommand("Select RoleName from [dbo].[Role_Master]", azureSQLDb);
                        var skilldata = await cmd.ExecuteScalarAsync();
                        data = JsonConvert.DeserializeObject<List<string>>(skilldata.ToString());
                        data = data.Where(x => x.Contains(skill, StringComparison.OrdinalIgnoreCase)).ToList();
                    }
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
