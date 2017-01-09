using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Project_HK.Models.EntityModels
{
    public class UserAccountModel
    {
        public long userID { get; set; }
        public string username { get; set; }
        public string lastname { get; set; }
        public string firstname { get; set; }
        public string role { get; set; }
    }
}