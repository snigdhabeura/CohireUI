// Please see documentation at https://docs.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.$('#upload').submit(function (e) {})

$("#post_form").submit(function (e) {
    e.preventDefault(); debugger;
    var formData = new FormData();
    var input = document.getElementById('fileupload');
    var files = input.files;
    for (var i = 0; i != files.length; i++) {
        formData.append("JobFiles", files[i]);
    }
    
    var jobtitle = $("#JobTitle").val();
    formData.append("Jobtitle", jobtitle);

    var categoryID = $("#JobCategory").val();
    formData.append("CategoryID", categoryID);

    var categoryName = $("#JobCategory option:selected").text();
    formData.append("Category_Name", categoryName);

    if ($("#hdn_job_type").val() == "1")
    {
        var Jobdescription = $("#floatingTextarea2").val();
        formData.append("JobDescription", Jobdescription);
    }
     else if ($("#hdn_job_type").val() == "2")
    {
        var Jobdescription = $("#txtJobReq").val();
        formData.append("JobDescription", Jobdescription);
    }
     else if ($("#hdn_job_type").val() == "3")
    {
        var Jobdescription = $("#PostJobDescription").val();
        formData.append("JobDescription", Jobdescription);
    }
    

    var ExperienceID = $("#Experience").val();
    formData.append("ExperienceID", ExperienceID);

    var ExperienceName = $("#Experience option:selected").text();
    formData.append("Experience_Name", ExperienceName);

    var Location = $("#Location").val();
    formData.append("city", Location);

    var EmploymenttypeID = $("#Employmenttype").val();
    formData.append("EmploymenttypeID", EmploymenttypeID);

    var EmploymenttypeName = $("#Employmenttype option:selected").text();
    formData.append("Employmenttype_Name", EmploymenttypeName);

    
    var SalaryRange = $("#SalaryRange").val();

    formData.append("Salaryrange", SalaryRange);
    formData.append("Is_Job", $("#hdn_job_type").val());


    $.ajax({
        url: '../Home/PostJob',
        type: this.method,
        data: formData,
        processData: false,
        contentType: false,
        success: function (data) {
            debugger;
            if (data.is_Error != true) {
                location.reload();
            }
        },
        error: function (xhr, error, status) {
            console.log(error, status);
        }
    });
});
