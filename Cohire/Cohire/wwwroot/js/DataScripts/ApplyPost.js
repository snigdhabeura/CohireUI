function ApplyJob() {
    var id = $("#apply_hdn").val();
    if ($("#btnApplyContinue").text() === 'Continue') {
        var retval = JobQuestions(id);
        if (retval.length > 0) {
            for (var i = 0; i < retval.length; i++) {
                $('#lblApplyScrQus' + i).text(retval[i]);
            }
            $("#divApplyPannel2").addClass('show');
            $("#divApplyPannel1").removeClass('show');
            $("#btnApplyContinue").text('Apply');
        } else {
            ApplyJobCnf();

            $("#divApplyPannel3").addClass('show');
            $("#divApplyPannel1 , #divApplyPannel2").removeClass('show');
            $("#btnApplyContinue").text('OK');
            $("#btnApplyContinue").attr("data-bs-dismiss", "modal");
        }
    }
    else if ($("#btnApplyContinue").text() === 'Apply') {
        ApplyJobCnf();
        $("#divApplyPannel3").addClass('show');
         $("#divApplyPannel1 , #divApplyPannel2").removeClass('show');
         $("#btnApplyContinue").text('OK');
         $("#btnApplyContinue").attr("data-bs-dismiss", "modal");
    }
    else if ($("#btnApplyContinue").text() === 'OK') {
            $("#divApplyPannel3 , #divApplyPannel2").removeClass('show');
            $("#divApplyPannel1").addClass('show');
            $("#btnApplyContinue").text('Continue');
    }
}
function ApplyJobCnf() {
    
    var PostID = $("#apply_hdn").val(); // $("#PostID").text();  

    var formData = new FormData();
    var ApplyFullName = $("#ApplyFullName").val();
    var ApplyPhone = $("#ApplyPhone").val();
    var Applyemail = $("#Applyemail").val();

    var input = document.getElementById('ApplyResume');
    var files = input.files;
    for (var i = 0; i != files.length; i++) {
        formData.append("ResumeFile", files[i]);
    }

    var ScrQus1 = $("#ScrQus1").val();
    var ScrQus2 = $("#ScrQus2").val();
    var ScrQus3 = $("#ScrQus3").val();
    var ScrQus4 = $("#ScrQus4").val();
    var ScrQus5 = $("#ScrQus5").val();

    var ScrAns1 = $("#lblApplyScrQus0").text();
    var ScrAns2 = $("#lblApplyScrQus1").text();
    var ScrAns3 = $("#lblApplyScrQus2").text();
    var ScrAns4 = $("#lblApplyScrQus3").text();
    var ScrAns5 = $("#lblApplyScrQus4").text();

    var PostQuestions = $('.ApplyQues').map(function(i, opt) {
    return $(opt).text();
    }).toArray();

    var Response = $('.QuesAResp').map(function(i, opt) {
    return $(opt).val();
    }).toArray();

    var ScrQues = []

    for(var i = 0; i < PostQuestions.length; i++){
        var data = {};
        var question = PostQuestions[i];
        var answer = Response[i]

        data.Question = question;
        data.Answer = answer;
       

        ScrQues.push(data);
    }
    var jsonString = JSON.stringify(ScrQues);

    formData.append("FullName", ApplyFullName);
    formData.append("Email", Applyemail);
    formData.append("Mobile", ApplyPhone);
    formData.append("ChJobID", PostID);
    formData.append("applyJobQuestions", jsonString);

    $.ajax({
        url: '../User/ApplyJobpost',
        type: "POST",
        data: formData,
        processData: false,
        contentType: false,
        async: false,
        success: function (data) {
            
        },
        error: function (xhr, error, status) {
            console.log(error, status);
        }
    });
}
function JobQuestions(id) {
    var Questions;
    $.ajax({
        url: "api/job/getquestions",
        dataType: "json",
        type: "GET",
        async: false,
        data: { jobID: id },
        success: function (data) {
            
            Questions = data;
        }
    });
    return Questions;
}