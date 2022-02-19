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
}
