using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VidiotsWebStore
{
    public partial class ArchiveCustomer : System.Web.UI.Page
    {
        private string strConn = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
        VidiotsAdminTemplate master;
        protected void Page_Load(object sender, EventArgs e)
        {
            master = (VidiotsAdminTemplate)this.Master;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            grvCustomers.DataBind();
        }
    }
}