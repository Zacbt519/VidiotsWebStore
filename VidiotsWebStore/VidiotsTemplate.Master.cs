using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VidiotsWebStore
{
    public partial class VidiotsTemplate : System.Web.UI.MasterPage
    {
        public string masterMessage
        {
            get { return lblMasterMessage.Text; }
            set { lblMasterMessage.Text = value; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string url = "SearchResults.aspx?searchTerm=" + txtSearch.Text;
            Response.Redirect(url);
        }
    }
}