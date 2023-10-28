﻿using System;
using EFCoreDemo.Models;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using Repository.Persistence;

namespace EFCoreDemo {
    class Program {
        static void Main(string[] args) {
            //DoCodeFirst();
            //DoQueries();
            //DoLoading();
            //DoEdit();
            //DoUnitOfWork();
        }
    }
}

/*
Create Data in CourseContext.OnModelCreating

            #region Add Tags
            var tags = new Dictionary<string, Tag>
            {
                {"c#", new Tag {Id = 1, Name = "c#"}},
                {"angularjs", new Tag {Id = 2, Name = "angularjs"}},
                {"javascript", new Tag {Id = 3, Name = "javascript"}},
                {"nodejs", new Tag {Id = 4, Name = "nodejs"}},
                {"oop", new Tag {Id = 5, Name = "oop"}},
                {"linq", new Tag {Id = 6, Name = "linq"}},
            };

            foreach (var tag in tags.Values)
                modelBuilder.Entity<Tag>().HasData(tag);
            #endregion

            #region Add Authors
            var authors = new List<Author>
            {
                new Author
                {
                    Id = 1,
                    Name = "Bill Gates"
                },
                new Author
                {
                    Id = 2,
                    Name = "Anthony Alicea"
                },
                new Author
                {
                    Id = 3,
                    Name = "Eric Wise"
                },
                new Author
                {
                    Id = 4,
                    Name = "Tom Owsiak"
                },
                new Author
                {
                    Id = 5,
                    Name = "John Smith"
                }
            };

            foreach (var author in authors)
                modelBuilder.Entity<Author>().HasData(author);
            #endregion

            #region Add Courses
            var courses = new List<object>
            {
                new
                {
                    Id = 1,
                    Title = "C# Basics",
                    AuthorId = 1,
                    FullPrice = 49.2m,
                    Description = "Description for C# Basics",
                    Level = CourseLevel.Beginner
                },
                new
                {
                    Id = 2,
                    Title = "C# Intermediate",
                    AuthorId = 1,
                    FullPrice = 49.2m,
                    Description = "Description for C# Intermediate",
                    Level = CourseLevel.Beginner
                },
                new
                {
                    Id = 3,
                    Title = "C# Advanced",
                    AuthorId = 1,
                    FullPrice = 69.9m,
                    Description = "Description for C# Advanced",
                    Level = CourseLevel.Advanced
                },
                new
                {
                    Id = 4,
                    Title = "Javascript: Understanding the Weird Parts",
                    AuthorId = 2,
                    FullPrice = 149.0m,
                    Description = "Description for Javascript",
                    Level = CourseLevel.Intermediate
                },
                new
                {
                    Id = 5,
                    Title = "Learn and Understand AngularJS",
                    AuthorId = 2,
                    FullPrice = 99m,
                    Description = "Description for AngularJS",
                    Level = CourseLevel.Intermediate
                },
                new
                {
                    Id = 6,
                    Title = "Learn and Understand NodeJS",
                    AuthorId = 2,
                    FullPrice = 149m,
                    Description = "Description for NodeJS",
                    Level = CourseLevel.Advanced
                },
                new
                {
                    Id = 7,
                    Title = "Programming for Complete Beginners",
                    AuthorId = 3,
                    FullPrice = 45m,
                    Description = "Description for Programming for Beginners",
                    Level = CourseLevel.Advanced
                },
                new
                {
                    Id = 8,
                    Title = "A 16 Hour C# Course with Visual Studio 2013",
                    AuthorId = 4,
                    FullPrice = 150.9m,
                    Description = "Description 16 Hour Course",
                    Level = CourseLevel.Beginner
                },
                new
                {
                    Id = 9,
                    Title = "Learn JavaScript Through Visual Studio 2013",
                    AuthorId = 4,
                    FullPrice = 20m,
                    Description = "Description Learn Javascript",
                    Level = CourseLevel.Intermediate
                }
            };

            foreach (var course in courses)
                modelBuilder.Entity<Course>().HasData(course);
            #endregion

            #region Add CourseTags
            var courseTags = new List<CourseTag>
            {
                             new CourseTag
                {
                    CourseId = 1,
                    TagId = tags["c#"].Id
                },
                               new CourseTag
                {
                    CourseId = 7,
                    TagId = tags["c#"].Id
                },
                               new CourseTag
                {
                    CourseId = 8,
                    TagId = tags["c#"].Id
                },
 new CourseTag
                {
                    CourseId = 3,
                    TagId = tags["c#"].Id
                },
                new CourseTag
                {
                    CourseId = 2,
                    TagId = tags["c#"].Id
                },
                      new CourseTag
                {
                    CourseId = 2,
                    TagId = tags["oop"].Id
                },
                      new CourseTag
                {
                    CourseId = 4,
                    TagId = tags["javascript"].Id
                },
                                  new CourseTag
                {
                    CourseId = 9,
                    TagId = tags["javascript"].Id
                },
          new CourseTag
                {
                    CourseId = 5,
                    TagId = tags["angularjs"].Id
                },
                      new CourseTag
                {
                    CourseId = 6,
                    TagId = tags["nodejs"].Id
                },

            };

            foreach (var courseTag in courseTags)
                modelBuilder.Entity<CourseTag>().HasData(courseTag);
            #endregion
*/
