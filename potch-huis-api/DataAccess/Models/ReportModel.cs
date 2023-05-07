using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Models;

public class ReportModel
{

    public class MonthlyRequests
    {
        public string Name { get; set; } = string.Empty;
        public string Year { get; set; } = string.Empty;
        public string Month { get; set; } = string.Empty;
        public string RequestCount { get; set; } = string.Empty;

    }
    public class MonthlyDonations
    {
        public string Year { get; set; } = string.Empty;
        public string Month { get; set; } = string.Empty;
        public string DonationCount { get; set; } = string.Empty;
    }
}
