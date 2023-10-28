﻿using EFCoreDemo;
using Repository.Core;
using Repository.Core.Repositories;
using Repository.Persistence.Repositories;

namespace Repository.Persistence
{
    public class UnitOfWork : IUnitOfWork
    {
        private readonly CourseContext _context;

        public UnitOfWork(CourseContext context)
        {
            _context = context;
            Courses = new CourseRepository(_context);
            Authors = new AuthorRepository(_context);
        }

        public ICourseRepository Courses { get; private set; }
        public IAuthorRepository Authors { get; private set; }

        public int Complete()
        {
            return _context.SaveChanges();
        }

        public void Dispose()
        {
            _context.Dispose();
        }
    }
}