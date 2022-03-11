using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PeopleSaver.Data;
using PeopleSaver.Models;

namespace PeopleSaver.Controllers;

public class HomeController : Controller
{
    public readonly IContext _context;

    public HomeController(IContext context)
    {
        _context = context;
    }

    public async Task<IActionResult> Index()
    {
        var people = await _context.People.ToListAsync();
        return View(new HomeIndexViewModel
        {
            People = people.Select(x => new PersonViewModel
            {
                Id = x.Id,
                FirstName = x.FirstName,
                LastName = x.LastName,
                Age = x.Age
            }).ToList()
        });
    }
}
