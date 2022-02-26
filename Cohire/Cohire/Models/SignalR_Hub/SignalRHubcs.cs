using Cohire.Controllers;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.SignalR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Cohire.Models.SignalR_Hub
{
    public class ChatHub : Hub
    {
        private readonly IHttpContextAccessor _httpContextAccessor;

        public ChatHub(IHttpContextAccessor httpContextAccessor)
        {
            this._httpContextAccessor = httpContextAccessor;
        }
        public async Task Sendmessage(string message,string postID)
        {
            Authentication authentication = new Authentication(_httpContextAccessor);
               var username = authentication.GetCurrentCookie();
            var Is_CommentInsert =await UserAuthentication.UserAuthentication.Instance.SetCommentForPost(postID, username[1], message);
            await Clients.All.SendAsync("ReceiveMessage", Is_CommentInsert.Profile_Image, Is_CommentInsert.FullName, Is_CommentInsert.Comment, Is_CommentInsert.ChJobID, Is_CommentInsert.Countofaction);
        }
        public async Task Sendmessagepop(string message, string postID)
        {
            Authentication authentication = new Authentication(_httpContextAccessor);
            var username = authentication.GetCurrentCookie();
            var Is_CommentInsert = await UserAuthentication.UserAuthentication.Instance.SetCommentForPost(postID, username[1], message);
            await Clients.All.SendAsync("ReceiveMessagepop", Is_CommentInsert.Profile_Image, Is_CommentInsert.FullName, Is_CommentInsert.Comment, Is_CommentInsert.ChJobID, Is_CommentInsert.Countofaction);
        }
    }
}
