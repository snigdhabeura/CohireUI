using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Cohire.Models.Response_Model
{
    public class Api_Response<T>
    {
        public bool Is_Error { get; set; }
        public int  Status_Code { get; set; }
        public T data { get; set; }
    }
   
}
