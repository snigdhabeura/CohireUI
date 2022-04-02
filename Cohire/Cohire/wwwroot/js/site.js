// Please see documentation at https://docs.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.$('#upload').submit(function (e) {})

$("#post_form").submit(function (e) {
    e.preventDefault(); 
    var formData = new FormData();
    var input = document.getElementById('fileupload');
    var files = input.files;
    for (var i = 0; i != files.length; i++) {
        formData.append("JobFiles", files[i]);
    }
    
    var Job_type = $("#hdn_job_type").val();
    formData.append("Is_Job", $("#hdn_job_type").val());
    if ($("#hdn_job_type").val() == "1")
    {
        var jobtitle = $("#JobTitle").val();
        formData.append("Jobtitle", jobtitle);

        var categoryID = $("#JobCategory").val();
        formData.append("CategoryID", categoryID);

        var categoryName = $("#JobCategory option:selected").text();
        formData.append("Category_Name", categoryName);

        var Jobdescription = $("#JobDesc").val();
        formData.append("JobDescription", Jobdescription);
        var ExperienceID = $("#Experience").val();
        formData.append("ExperienceID", ExperienceID);

        var ExperienceName = $("#Experience option:selected").text();
        formData.append("Experience_Name", ExperienceName);

       
        var getHireloc = $("#HireLocation").find('input[type="hidden"]');
        var getHireLocation = '';
        for (var i = 0; i < getHireloc.length; i++) {
            if (getHireloc.length == (i + 1)) {
                getHireLocation = getHireLocation + getHireloc[i].value;
            } else {
                getHireLocation = getHireLocation + getHireloc[i].value + ",";
            }

        } formData.append("city", getHireLocation);

        var EmploymenttypeID = $("#Employmenttype").val();
        formData.append("EmploymenttypeID", EmploymenttypeID);

        var EmploymenttypeName = $("#Employmenttype option:selected").text();
        formData.append("Employmenttype_Name", EmploymenttypeName);


        var SalaryRange = $("#SalaryRange").val();

        formData.append("Salaryrange", SalaryRange);
        
    }
     else if ($("#hdn_job_type").val() == "2")
    {
        var jobtitle = $("#HireJobTitle").val();
        formData.append("Jobtitle", jobtitle);

        var categoryID = $("#HireJobFunction").val();
        formData.append("CategoryID", categoryID);

        var categoryName = $("#HireJobFunction option:selected").text();
        formData.append("Category_Name", categoryName);

        var Jobdescription = $("#HireJobRequest").val();
        formData.append("JobDescription", Jobdescription);
        var skills = $("#HireSkills").find('input[type="hidden"]');
        var getallSkills = '';
        for (var i = 0; i < skills.length; i++) {
            if (skills.length == (i + 1)) {
                getallSkills = getallSkills + skills[i].value;
            } else {
                getallSkills = getallSkills + skills[i].value + ",";
            }
            
        }
        formData.append("Skills", getallSkills);

        var ExperienceID = $("#HireExperience").val();
        formData.append("ExperienceID", ExperienceID);

        var ExperienceName = $("#HireExperience option:selected").text();
        formData.append("Experience_Name", ExperienceName);

        var getHireloc = $("#getHireLocation").find('input[type="hidden"]');
        var getHireLocation = '';
        for (var i = 0; i < getHireloc.length; i++) {
            if (getHireloc.length == (i + 1)) {
                getHireLocation = getHireLocation + getHireloc[i].value;
            } else {
                getHireLocation = getHireLocation + getHireloc[i].value + ",";
            }

        } formData.append("city", getHireLocation);

        var EmploymenttypeID = $("#HireEmploymentType").val();
        formData.append("EmploymenttypeID", EmploymenttypeID);

        var EmploymenttypeName = $("#HireEmploymentType option:selected").text();
        formData.append("Employmenttype_Name", EmploymenttypeName);

        var SalaryRange = $("#HireAnnualSalary").val();

        formData.append("Salaryrange", SalaryRange);

        let isChecked = $('#chkANONYMOUS').prop('checked');
        if (isChecked == true) {
            formData.append("Is_masked_jobrequest", 1);
        } else {
            formData.append("Is_masked_jobrequest", 0);
        }
        
    }
     else if ($("#hdn_job_type").val() == "3")
    {
        var Jobdescription = $("#PostJobDescription").val();
        formData.append("JobDescription", Jobdescription);
    }

    $.ajax({
        url: '../Home/PostJob',
        type: this.method,
        data: formData,
        processData: false,
        contentType: false,
        success: function (data) {
            
            if (data.is_Error != true)
            {
                if (Job_type == 1)
                {
                    $("#postModal").modal('hide');
                    $("#job_postID_suc").val(data.data.chJobID);
                    $("#Post_Success_jobID").text(data.data.chJobID);
                    $("#NewpostCnfModal").modal('show');
                }
                else
                {
                    $("#postModal").modal('hide');
                    $("#simp_postid").text(data.data.chJobID);
                    $("#simplepost_Confirmation").modal('show');
                }
                
                //var getqsns = $("#ScrQus").find('input[type="text"]');
            }
        },
        error: function (xhr, error, status) {
            console.log(error, status);
        }
    });

});

function SaveScreenQuestion()
{
    
    var jobId = $("#job_postID_suc").val();
    var getqsns = $("#ScrQus").find('input[type="text"]');
    var question = [];
    for (var i = 0; i < getqsns.length; i++) {
        if (getqsns[i].value != '') {
            question.push(getqsns[i].value);
        }
    }
    $.ajax({
        url: "../Home/UpdateScreenQuestion",
        type: "POST",
        data: { chjobId: jobId, question: question },
        dataType: 'json',
        success: function (data) {
            $("#NewpostCnfModal").modal('hide'); location.reload(true);
        },
        error: function (xhr, error, status) {
            console.log(error, status);
        }
    });
}
///Comment Modal Actions
function OpenCommentModal(id)
{
    $("#commentModal").html('');
    $.ajax({
        url: "../Home/GetPostDetails",
        type: "POST",
        data: { JobID: id },
        dataType:'html',
        success: function (data) {
            
           
            $("#commentModal").append(data);
            $("#commentModal").modal('show');
        },
        error: function (xhr, error, status) {
            console.log(error, status);
        }
    });
    
    
}

function Searchcohyre() {
    var searchtext = $("#search_val").val();
    debugger;
    if (searchtext.length >= 3) {
        $.ajax({
            url: "../Home/SearchPrefix",
            type: "POST",
            data: { prefix: searchtext },
            dataType: 'json',
            success: function (data) {
                debugger;

                $("#searchbar_contain").html('');
                $("#searchbar_contain").html(data);
                $("#searchbar_contain").show();
            },
            error: function (xhr, error, status) {
                console.log(error, status);
            }
        });
    } else {
        $("#searchbar_contain").html('');
    }
    
}

