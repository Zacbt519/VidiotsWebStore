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
    public partial class Confirmation : System.Web.UI.Page
    {
        private string strConn = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
        VidiotsTemplate master;
        protected void Page_Load(object sender, EventArgs e)
        {
            master = (VidiotsTemplate)this.Master;
            if (!IsPostBack)
            {

            }

            string customerID = Request.QueryString["customerID"].ToString();
            if (!string.IsNullOrEmpty(customerID))
            {
                ConfirmAccount(customerID);
            }
        }

        private void ConfirmAccount(string customerID)
        {
            try
            {
                SqlCommand cmd = default(SqlCommand);
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    cmd = new SqlCommand("spConfirmAccount", conn);
                    cmd.Parameters.Add(new SqlParameter("@CustomerID", int.Parse(customerID)));
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                master.masterMessage = ex.Message;
            }
            
        }
    }
}