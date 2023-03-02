using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Models;

public class StockModel
{
    public string? Name { get; set; }
    public string? Description { get; set; }
    public string? Quantity { get; set; }
    public string? Value { get; set; }
    public DateTime LastUpdated { get; set; }
    public bool Active { get; set; }
}
