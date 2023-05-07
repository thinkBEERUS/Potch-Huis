using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Models;

public class DonationModel
{
    public string? Type { get; set; }
    public string? Amount { get; set; }
    public string? Received { get; set; }
    public string? MemberNumber { get; set; }
    public string? DonationNumber { get; set; }
    public string? Confirmed { get; set; }
    public string? ConfirmedBy { get; set; }
    public int Id { get; set; }
}
