using MultiMiner.Engine.Data;
using MultiMiner.Utility.Net;
using MultiMiner.Utility.OS;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Net;

namespace MultiMiner.Engine.Installers
{
    public static class AvailableMiners
    {
        public static List<AvailableMiner> GetAvailableMiners(string userAgent)
        {
            WebClient webClient = new ApiWebClient();
            webClient.Headers.Add("user-agent", userAgent);

            string platform = "win64";
            if (OSVersionPlatform.GetConcretePlatform() == PlatformID.MacOSX)
                platform = "osx64";
            
            string url = "https://github.com/zawawawa/gatelessgate/Misc/miners/" + platform;
            string response = webClient.DownloadString(new Uri(url));

            List<AvailableMiner> availableMiners = JsonConvert.DeserializeObject<List<AvailableMiner>>(response);
            return availableMiners;
        }
    }
}
