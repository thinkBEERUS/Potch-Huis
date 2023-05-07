using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Metadata.Ecma335;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Models;

public class RequestModel
{
    public string? RequestNumber { get; set; }
    public string? MemberNumber { get; set; }
    public string? Value { get; set; }
    public string? Received { get; set; } = "01/01/2000";
    public string? Confirmed { get; set; } = "01/01/2000";
    public int Id { get; set; }
}
