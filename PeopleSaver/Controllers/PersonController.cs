using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PeopleSaver.Data;
using PeopleSaver.Models;

namespace PeopleSaver.Controllers
{
    public class PersonController : Controller
    {
        private readonly IContext _context;

        public PersonController(IContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<IActionResult> View(Guid id)
        {
            var person = await _context.People.FirstOrDefaultAsync(x => x.Id == id);
            if (person == null)
            {
                return NotFound();
            }

            var viewModel = new PersonViewModel
            {
                Id = person.Id,
                FirstName = person.FirstName,
                LastName = person.LastName,
                Age = person.Age
            };
            return View(viewModel);
        }

        [HttpGet]
        public IActionResult Create()
        {
            return View(new PersonViewModel());
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromForm]PersonViewModel viewModel)
        {
            if (ModelState.IsValid == false)
            {
                return View(viewModel);
            }

            var person = new Person
            {
                FirstName = viewModel.FirstName,
                LastName = viewModel.LastName,
                Age = viewModel.Age
            };

            await _context.People.AddAsync(person);
            await _context.SaveChangesAsync();
            
            return RedirectToAction("Index", "Home");
        }

        [HttpGet]
        public async Task<IActionResult> Edit(Guid id)
        {
            var person = await _context.People.FirstOrDefaultAsync(x => x.Id == id);
            if (person == null)
            {
                return NotFound();
            }

            var viewModel = new PersonViewModel
            {
                Id = person.Id,
                FirstName = person.FirstName,
                LastName = person.LastName,
                Age = person.Age
            };

            return View(viewModel);
        }

        [HttpPost]
        public async Task<IActionResult> Edit(Guid id, [FromForm]PersonViewModel viewModel)
        {
            if (ModelState.IsValid == false)
            {
                return View(viewModel);
            }

            var person = await _context.People.FirstOrDefaultAsync(x => x.Id == id);
            if (person == null)
            {
                return NotFound();
            }

            person.FirstName = viewModel.FirstName;
            person.LastName = viewModel.LastName;
            person.Age = viewModel.Age;

            await _context.SaveChangesAsync();

            return RedirectToAction("Index", "Home");
        }

        [HttpGet]
        public async Task<IActionResult> Delete(Guid id)
        {
            var person = await _context.People.FirstOrDefaultAsync(x => x.Id == id);
            if (person == null)
            {
                return NotFound();
            }

            var viewModel = new PersonViewModel
            {
                Id = person.Id,
                FirstName = person.FirstName,
                LastName = person.LastName,
                Age = person.Age
            };

            return View(viewModel);
        }

        [HttpPost]
        public async Task<IActionResult> Confirm(Guid id)
        {
            var person = await _context.People.FirstOrDefaultAsync(x => x.Id == id);
            if (person == null)
            {
                return NotFound();
            }

            _context.People.Remove(person);
            await _context.SaveChangesAsync();

            return RedirectToAction("Index", "Home");
        }
    }
}