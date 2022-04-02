using Cohire.Models.Profile;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Cohire.Models.JobFeedListNM
{
    public class JobFile
    {
        public string filetype { get; set; }
        public string fileurl { get; set; }
        public string filename { get; set; }
    }

    public class JobFeedList
    {
        public string BaseURL { get; set; }
        public string JobId { get; set; }
        public string ChJobID { get; set; }
        public string PostedByID { get; set; }
        public string PostedByName { get; set; }
        public string RoleId { get; set; }
        public string Jobtitle { get; set; }
        public int CategoryID { get; set; }
        public string Category_Name { get; set; }
        public int ExperienceID { get; set; }
        public string Experience_Name { get; set; }
        public int EmploymenttypeID { get; set; }
        public string Employmenttype_Name { get; set; }
        public string Salaryrange { get; set; }
        public string JobDescription { get; set; }
        public int Is_Job { get; set; }
        public string Ip_Address { get; set; }
        public string Device_Type { get; set; }
        public string CreatedDate { get; set; }
        public List<string> city { get; set; }
        public List<string> Skills { get; set; }
        public List<string> JobQuestions { get; set; }
        public List<JobFile> JobFiles { get; set; }
        public string shareURL { get; set; }
        public List<string> Comments { get; set; }
        public string applyCount { get; set; }
        public string referCount { get; set; }
        public string likeCount { get; set; }
        public string commentCount { get; set; }
    }

    public class JobActionModel
    {
        public string JobJson { get; set; }
        public int Comment_Count { get; set; }
        public int Like_Count { get; set; }
        public int Apply_Count { get; set; }
        public int Refer_Count { get; set; }
        public JobFeedList jobFeedList { get; set; }
    }

    public class Searchresult
    {
        public int tp { get; set; }
        public string jsonstring { get; set; }
    }

    public class Searchreponse
    {
        public int jobcount { get; set; }
        public int postcount { get; set; }
        public int peoplecount { get; set; }
        public List<postjobsearch> postJobModels { get; set; }
        public List<ProfileModel> profileModels { get; set; }
    }

    public class postjobsearchJobFile
    {
        public string filetype { get; set; }
        public string fileurl { get; set; }
        public string filename { get; set; }
    }

    public class postjobsearch
    {
        public string JobId { get; set; }
        public string ChJobID { get; set; }
        public string PostedByID { get; set; }
        public string PostedByName { get; set; }
        public object RoleId { get; set; }
        public string Jobtitle { get; set; }
        public int CategoryID { get; set; }
        public string Category_Name { get; set; }
        public int ExperienceID { get; set; }
        public string Experience_Name { get; set; }
        public int EmploymenttypeID { get; set; }
        public string Employmenttype_Name { get; set; }
        public string Salaryrange { get; set; }
        public string JobDescription { get; set; }
        public int Is_Job { get; set; }
        public object Ip_Address { get; set; }
        public object Device_Type { get; set; }
        public string CreatedDate { get; set; }
        public List<string> city { get; set; }
        public List<string> Skills { get; set; }
        public object JobQuestions { get; set; }
        public List<postjobsearchJobFile> JobFiles { get; set; }
        public object NoteTorecruiter { get; set; }
        public object latestinfojobrequest { get; set; }
        public int Is_masked_jobrequest { get; set; }
        public string likeCount { get; set; }
        public object comment { get; set; }
        public string applyCount { get; set; }
        public string referCount { get; set; }
        public string commentCount { get; set; }
    }


    #region ------------------ Job Search Model----------------
    public class Jobcard
    {
        public string skip { get; set; }
        public string take { get; set; }
        public string totalresultfound { get; set; } = "0";
        public string searchtype { get; set; }
        public string Searchfor { get; set; }
        public string Searchtext { get; set; }
        public List<postjobsearch> listofjob { get; set; }
        public List<ProfileModel> profileModels { get; set; }
    }
    public class JobJsonRoot
    {
        public string jsonstring { get; set; }
    }
    #endregion
}
