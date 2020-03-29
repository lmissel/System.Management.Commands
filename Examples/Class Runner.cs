public class Runner
{
    public static string RunExecutable(string machine, string executable, string username, string password, string domain)
    {
        try
        {
            ConnectionOptions connectionOptions = new ConnectionOptions();
            connectionOptions.Authority = "kerberos:" + domain + @"\" + machine;
            connectionOptions.Username = username;
            connectionOptions.Password = password;
            connectionOptions.Impersonation = ImpersonationLevel.Delegate;
            connectionOptions.Authentication = AuthenticationLevel.PacketPrivacy;

            //define the WMI root name space
            ManagementScope scope = new ManagementScope(@"\\" + machine + "." + domain + @"\root\CIMV2", connectionOptions);

            //define path for the WMI class
            ManagementPath p = new ManagementPath("Win32_Process");

            //define new instance
            ManagementClass classInstance = new ManagementClass(scope, p, null);
            ManagementClass startupSettings = new ManagementClass("Win32_ProcessStartup");
            startupSettings.Scope = scope;
            startupSettings["CreateFlags"] = 16777216;

            //Obtain in-parameters for the method
            ManagementBaseObject inParams = classInstance.GetMethodParameters("Create");

            //Add the input parameters.
            inParams["CommandLine"] = executable;
            inParams["ProcessStartupInformation"] = startupSettings;

            //Execute the method and obtain the return values.
            ManagementBaseObject outParams = classInstance.InvokeMethod("Create", inParams, null);

            //List outParams
            string retVal = outParams["ReturnValue"].ToString();
            return "ReturnValue: " + retVal;
        }
        catch (ManagementException me)
        {
            return me.Message;
        }
        catch (COMException ioe)
        {
            return ioe.Message;
        }
    }
}