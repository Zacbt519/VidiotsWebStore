using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VidiotsWebStore
{
    public partial class CustomerLogin : System.Web.UI.Page
    {
        string isFromCheckout;
        protected void Page_Load(object sender, EventArgs e)
        {
            isFromCheckout = Request.QueryString["fromCheckOut"];
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(isFromCheckout))
            {
                if(int.Parse(isFromCheckout) == 1)
                {

                }
            }
        }
    }
}