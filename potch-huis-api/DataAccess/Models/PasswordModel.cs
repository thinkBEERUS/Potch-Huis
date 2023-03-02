using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Models;

public class PasswordModel
{
    public byte[]? Salt { get; set; }
    public string? Hash { get; set; }
    public string? MemberNumber { get; set;}
}
