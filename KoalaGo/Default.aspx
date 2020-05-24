<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="KoalaGo.Default" %>

<html>
<head runat="server">
    <title></title>

    <style>
        .center {
            position: absolute;
            margin: auto;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            width: 400px;
            height: 100px;
            border-radius: 3px;
        }
    </style>
</head>
<body style="background-image: url('Images/koala.jpg'); background-repeat: no-repeat; width: 100%; height: 100%; background-size: cover;">

    <form id="form1" runat="server">
        <div class="center">

            <table>
                <tr>
                    <td>
                        <asp:Label ID="lblmsg" runat="server" Font-Size="Large" ForeColor="Red"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="qaaa" runat="server" Text="Security Code" Font-Size="Large" Font-Bold="False" ForeColor="#CC9900"></asp:Label><asp:TextBox ID="txtcode" runat="server" Height="38px" Width="164px" TextMode="Password"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Button ID="btn1" runat="server" Text="Verify" OnClick="btn1_Click" Font-Size="Medium" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>