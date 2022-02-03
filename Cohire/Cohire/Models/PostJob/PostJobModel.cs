using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;

namespace CohireAPI.PostJobs.Model
{
    public class PostJobModel
    {
        public Guid? JobId { get; set; }
        public string ChJobID { get; set; }
        public string PostedByID { get; set; }
        public string PostedByName { get; set; }
        public string RoleId { get; set; }
        public string Jobtitle { get; set; }
        public string city { get; set; }
        public int CategoryID { get; set; }
        public string Category_Name { get; set; }
        public int ExperienceID { get; set; }
        public string Experience_Name { get; set; }
        public int EmploymenttypeID { get; set; }
        public string Employmenttype_Name { get; set; }
        public string Salaryrange { get; set; }
        public string JobDescription { get; set; }  
        public string Skills { get; set; }
        public string JobQuestions{ get; set; }
        public int Is_Job { get; set; }
        public string Ip_Address { get; set; }
        public string Device_Type { get; set; }
        public List<IFormFile> JobFiles { get; set; }

    }

    public class UpdatePostJobModel
    {
        public Guid? JobId { get; set; }
        public string ChJobID { get; set; }
        public string PostedByID { get; set; }
        public string PostedByName { get; set; }
        public string RoleId { get; set; }
        public string Jobtitle { get; set; }
        public string city { get; set; }
        public int CategoryID { get; set; }
        public string Category_Name { get; set; }
        public int ExperienceID { get; set; }
        public string Experience_Name { get; set; }
        public int EmploymenttypeID { get; set; }
        public string Employmenttype_Name { get; set; }
        public string Salaryrange { get; set; }
        public string JobDescription { get; set; }
        public string Skills { get; set; }
        public string JobQuestions { get; set; }
        public int Is_Job { get; set; }
        public string Ip_Address { get; set; }
        public string Device_Type { get; set; }
        public List<IFormFile> JobFiles { get; set; }
        public string presentjobfiles { get; set; }
    }
    public class ViewPostJobModel
    {
        public Guid? JobId { get; set; }
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
        public List<PostJobFiles> JobFiles { get; set; }

    }

    public class PostJobFiles
    {
        public string filetype { get; set;}
        public string fileurl { get; set; }
        public string filename { get; set; }
    }

    public class UpdateJobFiles
    {
        public string filetype { get; set; }
        public string fileurl { get; set; }
        public string Is_Delete { get; set; }
    }
    public class ApplyJobGetModel
    {
        public string CHProfileID { get; set; }
        public string FullName { get; set; }
        public string Email { get; set; }
        public string Mobile { get; set; }
        public string ChJobID { get; set; }
        public string JobJson { get; set; }
        public List<string>JobQuestion { get; set; }
    }

    public class ApplyJobSubMit
    {
        public string CHProfileID { get; set; }
        public string FullName { get; set; }
        public string Email { get; set; }
        public string Mobile { get; set; }
        public string ChJobID { get; set; }
        public string ApplyJobJson { get; set; }
        public IFormFile ResumeFile { get; set; }
        public string  ResumeFileUrl { get; set; }
        public List<ApplyJobQuestionAnswer> applyJobQuestionAnswers { get; set; }
        public bool Is_termAccept { get; set; }

    }
    public class ApplyJobSubMitinsert
    {
        public string CH_ApllyJobID { get; set; }
        public string CHProfileID { get; set; }
        public string FullName { get; set; }
        public string Email { get; set; }
        public string Mobile { get; set; }
        public string ChJobID { get; set; }
        public string ApplyJobJson { get; set; }
        public string ResumeFileUrl { get; set; }
        public string applyJobQuestionAnswers { get; set; }
        public bool Is_termAccept { get; set; }

    }
    public class ApplyJobQuestionAnswer
    {
        public string Question { get; set; }
        public string Answer { get; set; }
    }

}
