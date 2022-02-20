$(document).ready(function () {
    

    $(".Applyctn").click(function () {
        var Data = '<div class="col-md-6 ApplyNext collapse" id="collapseExample" style="text-align:center"><div class="d-flex flex-column h-600" style="padding-right:10%"><h4 style="text-align:center;font-weight:bold">Screening Questions</h4><div class="form-floating mb-1 d-flex align-items-cente"><select class="form-select  rounded-5" id="questions1" data-live-search="true" aria-label="Floating label select example"><option>Select a category</option>                <option>Marketing &amp; Communication</option>                <option>Software gineering</option>                <option>Project Management</option><option>Finance</option><option>Retail</option><option>Sales</option><option>Manufacturing</option><option>IT</option><option>Business Development</option><option>Human Resources</option><option>Customer Service</option></select><label for="questions1">Screening questions1 ?</label></div><div class="form-floating mb-1 d-flex align-items-cente"><select class="form-select  rounded-5" id="questions2" data-live-search="true" aria-label="Floating label select example"><option>Select a category</option><option>Marketing &amp; Communication</option><option>Software Engineering</option></select><label for="questions2">Screening questions2 ?</label></div><div class="form-floating mb-1 d-flex align-items-center"><input type="text" class="form-control rounded-5" id="questions3" placeholder="Screening questions3 ?"><label for="questions3">Screening questions3 ?</label></div><div class="form-floating mb-1 d-flex align-items-center"><input type="text" class="form-control rounded-5" id="questions4" placeholder="Screening questions4 ?"><label for="questions4">Screening questions4 ?</label></div><div class="form-floating mb-1 d-flex align-items-center"><input type="text" class="form-control rounded-5" id="questions5" placeholder="Screening questions5 ?"><label for="questions5">Screening questions5 ?</label></div><div lass="d-grid"></div></div></div>';
        if ($(".Applyctn").val() != 'Apply') {
            $(".applyChange").removeClass('col-md-12').addClass('col-md-6');
            $(".modelapply").addClass('modal-lg');
            $(".AddHtml").append(Data);
            $(".Applyctn").text("Apply");
            $(".Applyctn").val("Apply");
        } else {
            $("#btnApplybtn").modal("hide");
            $("#ApplyConfirmation").modal("show");

            $("#collapseExample").remove();
            $(".Applyctn").text('Continue')
            $(".applyChange").removeClass('col-md-6').addClass('col-md-12');
            $(".modelapply").removeClass('modal-lg');
        }
        $(".ApplyNext").removeClass('d-none');
    });


    $("#btnApplyOk").click(function () {
        $('.modal').modal('hide');

        $(".modal").removeClass('fade');
    });


    $("#btnContinue").click(function () {
        $(".ApplyPannel1").addClass('collapse');
        $(".ApplyPannel2").removeClass('collapse');
        $("#ApplyModalHeader").addClass('modal-lg');
        if ($("#btnContinue").text() != 'Apply') {
            $("#btnContinue").text('Apply');
        }
        else {
            $(".ApplyModal").modal("hide");
            $("#ApplyConfirmation").modal("show");
        }

    });

    $("#btnReferTerm").click(function () {
        $("#btnTermsOk").attr("href", ".ReferModal");
        $("#btnTermsback").attr("href", ".ReferModal");
    });

});
//Share URL 
function ShareURL(url) {
    if (CheckIs_login()) {
        $("#pxp-share-url").text(url);
        $("#fbshare").attr('href', 'https://facebook.com/sharer.php?u=' + url);
        $("#linkedinshare").attr('href', 'https://www.linkedin.com/shareArticle/?url=' + url);
        $("#twittershare").attr('href', 'https://twitter.com/intent/tweet?url=' + url);
        $("#whatsappshare").attr('href', 'https://wa.me/?text=' + url);
        $('#pxp-share-modal').modal("show");
    }
}
function copyToClipboard() {
    debugger;
    var $temp = $("<input>");
    $("#pxp-share-modal").append($temp);
    $temp.val($("#pxp-share-url").text()).select();
    document.execCommand("copy");
    $temp.remove();
    $("#link_copy_txt").fadeIn("slow");
    $("#link_copy_txt").fadeOut("slow");
}

//Like Function
function IncreaseLike(id) {
    debugger;
    var Is_like = 0;
    
    if (CheckIs_login()) {
        if ($("#likebtns_" + id + "").hasClass('unlike')) {
            $("#likebtns_" + id + "").removeClass('unlike');
            $("#likebtns_" + id + "").css('color', '');
            var getCount = $("#likeCount_" + id + "").html();
            getCount = parseFloat(getCount) - 1;
            $("#likeCount_" + id + "").html(getCount);

        } else {
            $("#likebtns_" + id + "").addClass('unlike');
            $("#likebtns_" + id + "").css('color', 'dodgerblue');
            var getCount = $("#likeCount_" + id + "").html();
            getCount = parseFloat(getCount) + 1;
            Is_like = 1;
            $("#likeCount_" + id + "").html(getCount);
        }
        $.ajax({
            url: '../User/InserLikeCount',
            type: 'POST',
            data: { jobID: id, Is_like: Is_like},
            success: function (data) {
                
                $(".likeCount_" + id + "").html(data);
            },
            error: function (xhr, error, status) {
                console.log(error, status);
            }
        });
    }
}

//refere
function GetReferModel(id) {
    if (CheckIs_login()) {
        $("#referbody_hdn").val(id);
        $("#ReferModal").modal('show');
    }
}
function ShowreferTerm() {
    debugger;
    $("#refer_term").show();
    $("#referbody").hide();
}
function HidereferTerm() {
    debugger;
    $("#refer_term").hide();
    $("#referbody").show();
}


$('#upload').submit(function (e) {
    debugger;
    var Is_error = 0;
    if ($("#ReferFullName").val() == '') {
        $("#ReferFullName_err").css('color', 'red');
        Is_error = 1;
    } else {
        $("#ReferFullName_err").css('color', '');
    }
    if (($("#ReferPhone").val() == '')) {
        $("#ReferPhone_err").css('color', 'red');
        Is_error = 1;
    }
    else {
        $("#ReferPhone_err").css('color', '');
    }
    if ($("#Referemail").val() == '') {
        $("#Referemail_err").css('color', 'red');
        Is_error = 1;

    } else {
        $("#Referemail_err").css('color', '');
    }
    if ($("#ReferResume").val() == '') {
        $("#ReferResume_err").css('color', 'red');
        Is_error = 1;
    } else {
        $("#ReferResume_err").css('color', '');
    }
    if ($("#flexCheckDefault_refer").prop('checked') != true) {
        $("#referecheckbox").html('Please check the terms of use!!!');
        $("#referecheckbox").fadeIn("slow");
        $("#referecheckbox").fadeOut("slow");
        Is_error = 1;
    }
    if (Is_error == 1) {
        return false;
    } else {

    }
    debugger;
    var formData = new FormData();
    var input = document.getElementById('ReferResume');
    var files = input.files;
    for (var i = 0; i != files.length; i++) {
        formData.append("Attachments", files[i]);
    }
    formData.append("Fullname", $("#ReferFullName").val());
    formData.append("mobile", $("#ReferPhone").val());
    formData.append("email", $("#Referemail").val());
    formData.append("chJobID", $("#referbody_hdn").val());
    if ($("#flexCheckDefault_refer").prop('checked') != true) {
        formData.append("Is_term", 0);
    } else {
        formData.append("Is_term", 1);
    }
    e.preventDefault(); // stop the standard form submission
    $.ajax({
        url: this.action,
        type: this.method,
        data: formData,
        processData: false,
        contentType: false,
        success: function (data) {
            if (data != 0) {
                $("#confirm_referID").html("ReferID : " + data);
                $("#ReferModal").modal('hide');
                $("#referConfirmation").modal('show');
                debugger;
                var prvrefcount = $(".refer_count_" + $("#referbody_hdn").val() + "").text();
                $(".refer_count_" + $("#referbody_hdn").val() + "").html('');
                $(".refer_count_" + $("#referbody_hdn").val() + "").text(parseInt(prvrefcount)+1);
            } else {
                alert("Please try after sometime");
            }

        },
        error: function (xhr, error, status) {
            console.log(error, status);
        }
    });
});

function ReferConfirm() {
    $('#referConfirmation').modal('hide');
    $("#ReferFullName").val('');
    $("#ReferPhone").val('');
    $("#Referemail").val('');
    $("#ReferResume").val('');
    $("#flexCheckDefault_refer").prop('checked', false);
}


"use strict";

var connection = new signalR.HubConnectionBuilder().withUrl("/chatHub").build();
var message = '';
var postID = '';
connection.start().then(function () {
    $('.postcmnt').show();
}).catch(function (err) {
    return console.error(err.toString());
});
connection.on("ReceiveMessage", function (image, user, message, postID, Countofaction) {
    
    debugger; 
    var commentHtml = '';
    commentHtml = commentHtml + '<div class="d-flex mb-2">';
    commentHtml = commentHtml + '<a href="#" class="text-dark text-decoration-none">';
    debugger;
    if (image == null || image == '') {
        commentHtml = commentHtml + '<img src="../images/customer-1.png" class="img-fluid rounded-circle" alt="commenters-img">';

    } else {
        commentHtml = commentHtml + '<img src="../images/ProfileImage/' + image + '" class="img-fluid rounded-circle" alt="commenters-img">';

    }
    commentHtml = commentHtml + '</a>';
    commentHtml = commentHtml + '<div class="ms-2 small">';
    commentHtml = commentHtml + ' <a href="#" class="text-dark text-decoration-none">';
    commentHtml = commentHtml + '<div class="bg-light px-3 py-2 rounded-4 mb-1 chat-text">';
    commentHtml = commentHtml + '<p class="fw-500 mb-0">' + user + '</p>';
    commentHtml = commentHtml + '<span class="text-muted">' + message + '</span>';
    commentHtml = commentHtml + '</div></a></div></div>';
    $("#cmnt_div_" + postID + "").append(commentHtml);
    $("#cmt_popup").append(commentHtml);
    $(".cmnt_count_" + postID + "").text(Countofaction);
});
function Postcomment(id) {
    if (CheckIs_login()) {
        message = $("#cmnt_" + id + "").val();
        postID = id;
        connection.invoke("SendMessage",message, postID).catch(function (err) {
            return console.error(err.toString());
            event.preventDefault();
        });
        $("#cmnt_" + id + "").val(''); $("#cmnt_div_" + postID + "").html('');
        LoadComments(id);
    }
}
$(".cmnt_box").keyup(function (event) {
    if (event.keyCode === 13)
    {
        debugger;
        Postcomment($(this).attr('JobAtr'));
    }
});




function LoadCommentspopup(jobid) {
    $.ajax({
        url: "../User/GetCommentForPost",
        type: "POST",
        data: { jobID: jobid},
        success: function (data) {
            debugger;
            for (var i = 0; i < data.length; i++) {
                var comments = data[i];
                var commentHtml = '';
                commentHtml = commentHtml + '<div class="d-flex mb-2">';
                commentHtml = commentHtml + '<a href="#" class="text-dark text-decoration-none" data-bs-toggle="modal" data-bs-target="#commentModal">';
                if (comments.profile_Image == null || comments.profile_Image == '') {
                    commentHtml = commentHtml + '<img src="../images/customer-1.png" class="img-fluid rounded-circle" alt="commenters-img">';
                } else {
                    commentHtml = commentHtml + '<img src="../images/ProfileImage/' + comments.profile_Image + '" class="img-fluid rounded-circle" alt="commenters-img">';
                }
                commentHtml = commentHtml + '</a>';
                commentHtml = commentHtml + '<div class="ms-2 small">';
                commentHtml = commentHtml + ' <a href="#" class="text-dark text-decoration-none" data-bs-toggle="modal" data-bs-target="#commentModal">';
                commentHtml = commentHtml + '<div class="bg-light px-3 py-2 rounded-4 mb-1 chat-text">';
                commentHtml = commentHtml + '<p class="fw-500 mb-0">' + comments.fullName + '</p>';
                commentHtml = commentHtml + '<span class="text-muted">' + comments.comment + '</span>';
                commentHtml = commentHtml + '</div></a></div></div>';
             
                $("#cmt_popup").append(commentHtml);
                $("#cmt_popup").addClass('ex3pop');
                
                
            }
        },
        error: function (xhr, error, status) {
            console.log(error, status);
        }
    });
}
function LoadComments(jobid) {
    $("#cmnt_div_" + jobid + "").html('');
    $.ajax({
        url: "../User/GetCommentForPost",
        type: "POST",
        data: { jobID: jobid },
        async:false,
        success: function (data) {
            debugger;
            for (var i = 0; i < data.length; i++) {
                var comments = data[i];
                var commentHtml = '';
                commentHtml = commentHtml + '<div class="d-flex mb-2">';
                commentHtml = commentHtml + '<a href="#" class="text-dark text-decoration-none" data-bs-toggle="modal" data-bs-target="#commentModal">';
                if (comments.profile_Image == null || comments.profile_Image == '') {
                    commentHtml = commentHtml + '<img src="../images/customer-1.png" class="img-fluid rounded-circle" alt="commenters-img">';
                } else {
                    commentHtml = commentHtml + '<img src="../images/ProfileImage/' + comments.profile_Image + '" class="img-fluid rounded-circle" alt="commenters-img">';
                }
                commentHtml = commentHtml + '</a>';
                commentHtml = commentHtml + '<div class="ms-2 small">';
                commentHtml = commentHtml + ' <a href="#" class="text-dark text-decoration-none" data-bs-toggle="modal" data-bs-target="#commentModal">';
                commentHtml = commentHtml + '<div class="bg-light px-3 py-2 rounded-4 mb-1 chat-text">';
                commentHtml = commentHtml + '<p class="fw-500 mb-0">' + comments.fullName + '</p>';
                commentHtml = commentHtml + '<span class="text-muted">' + comments.comment + '</span>';
                commentHtml = commentHtml + '</div></a></div></div>';

                $("#cmnt_div_" + jobid+"").append(commentHtml);
                $("#cmnt_div_" + jobid+"").addClass('ex3');


            }
        },
        error: function (xhr, error, status) {
            console.log(error, status);
        }
    });
}