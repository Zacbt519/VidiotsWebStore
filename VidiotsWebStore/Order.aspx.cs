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
    public partial class Order : System.Web.UI.Page
    {
        private string strConn = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
        VidiotsTemplate master;
        protected void Page_Load(object sender, EventArgs e)
        {
            master = (VidiotsTemplate)this.Master;
            string customerID = Session["customerID"].ToString();
            if (!IsPostBack)
            {
                GetBillingAddress(customerID);
            }
        }

        private void GetBillingAddress(string customerID)
        {
            try
            {
                SqlDataReader dr = default(SqlDataReader);
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    SqlCommand cmd = new SqlCommand("spGetCustomerBillingAddress", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@CustomerID", int.Parse(customerID)));
                    conn.Open();
                    dr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
                    if (dr.HasRows)
                    {
                        dr.Read();
                        streetAddress.InnerText = dr["Street"].ToString();
                        cityAndProvince.InnerText = dr["City"].ToString() + ", " + dr["Province"].ToString();
                        country.InnerText = dr["Country"].ToString();
                        postalCode.InnerText = dr["PostalCode"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                master.masterMessage = ex.Message;
            }
            finally
            {
                master.masterMessage = "Address Retrieved";
            }
        }

        protected void chkShipping_CheckedChanged(object sender, EventArgs e)
        {
            if(chkShipping.Checked == true)
            {
                pnlShipping.Visible = true;
            }
            else
            {
                pnlShipping.Visible = false;
            }
        }

        protected void rdoPaypal_CheckedChanged(object sender, EventArgs e)
        {
            pnlCredit.Visible = false;
        }

        protected void rdoCredit_CheckedChanged(object sender, EventArgs e)
        {
            pnlCredit.Visible = true;
        }
    }
}