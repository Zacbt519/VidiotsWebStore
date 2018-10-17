using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VidiotsWebStore
{
    public partial class ShoppingCart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if(Request.Cookies["cartID"] != null)
                {
                    string cartID = Request.Cookies["cartID"].Value;
                    AddToCart(cartID);
                }
                else
                {
                    string cartID = CreateNewCart();
                    AddToCart(cartID);
                }
            }
        }

        private string CreateNewCart()
        {
            throw new NotImplementedException();
        }

        private void AddToCart(string cartID)
        {
            throw new NotImplementedException();
        }
    }
}