﻿// <auto-generated />
using System;
using EFCoreDemo;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

namespace EFCoreDemo.Migrations
{
    [DbContext(typeof(CourseContext))]
    [Migration("20201110195741_AddQueryData")]
    partial class AddQueryData
    {
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .UseIdentityColumns()
                .HasAnnotation("Relational:MaxIdentifierLength", 128)
                .HasAnnotation("ProductVersion", "5.0.0-rc.2.20475.6");

            modelBuilder.Entity("EFCoreDemo.Models.Author", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .UseIdentityColumn();

                    b.Property<string>("City")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Phone")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("Authors");

                    b.HasData(
                        new
                        {
                            Id = 10,
                            Name = "Max"
                        },
                        new
                        {
                            Id = 1,
                            Name = "Bill Gates"
                        },
                        new
                        {
                            Id = 2,
                            Name = "Anthony Alicea"
                        },
                        new
                        {
                            Id = 3,
                            Name = "Eric Wise"
                        },
                        new
                        {
                            Id = 4,
                            Name = "Tom Owsiak"
                        },
                        new
                        {
                            Id = 5,
                            Name = "John Smith"
                        });
                });

            modelBuilder.Entity("EFCoreDemo.Models.Category", b =>
                {
                    b.Property<int>("Id")
                        .HasColumnType("int");

                    b.Property<string>("Name")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("Categories");
                });

            modelBuilder.Entity("EFCoreDemo.Models.Course", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .UseIdentityColumn();

                    b.Property<int?>("AuthorId")
                        .HasColumnType("int");

                    b.Property<int?>("CategoryId")
                        .HasColumnType("int");

                    b.Property<string>("Description")
                        .HasColumnType("nvarchar(max)");

                    b.Property<decimal>("FullPrice")
                        .HasColumnType("decimal(7,2)");

                    b.Property<int>("Level")
                        .HasColumnType("int");

                    b.Property<string>("Title")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.HasIndex("AuthorId");

                    b.HasIndex("CategoryId");

                    b.ToTable("Courses");

                    b.HasData(
                        new
                        {
                            Id = 1,
                            AuthorId = 1,
                            Description = "Description for C# Basics",
                            FullPrice = 49.2m,
                            Level = 1,
                            Title = "C# Basics"
                        },
                        new
                        {
                            Id = 2,
                            AuthorId = 1,
                            Description = "Description for C# Intermediate",
                            FullPrice = 49.2m,
                            Level = 1,
                            Title = "C# Intermediate"
                        },
                        new
                        {
                            Id = 3,
                            AuthorId = 1,
                            Description = "Description for C# Advanced",
                            FullPrice = 69.9m,
                            Level = 3,
                            Title = "C# Advanced"
                        },
                        new
                        {
                            Id = 4,
                            AuthorId = 2,
                            Description = "Description for Javascript",
                            FullPrice = 149.0m,
                            Level = 2,
                            Title = "Javascript: Understanding the Weird Parts"
                        },
                        new
                        {
                            Id = 5,
                            AuthorId = 2,
                            Description = "Description for AngularJS",
                            FullPrice = 99m,
                            Level = 2,
                            Title = "Learn and Understand AngularJS"
                        },
                        new
                        {
                            Id = 6,
                            AuthorId = 2,
                            Description = "Description for NodeJS",
                            FullPrice = 149m,
                            Level = 3,
                            Title = "Learn and Understand NodeJS"
                        },
                        new
                        {
                            Id = 7,
                            AuthorId = 3,
                            Description = "Description for Programming for Beginners",
                            FullPrice = 45m,
                            Level = 3,
                            Title = "Programming for Complete Beginners"
                        },
                        new
                        {
                            Id = 8,
                            AuthorId = 4,
                            Description = "Description 16 Hour Course",
                            FullPrice = 150.9m,
                            Level = 1,
                            Title = "A 16 Hour C# Course with Visual Studio 2013"
                        },
                        new
                        {
                            Id = 9,
                            AuthorId = 4,
                            Description = "Description Learn Javascript",
                            FullPrice = 20m,
                            Level = 2,
                            Title = "Learn JavaScript Through Visual Studio 2013"
                        });
                });

            modelBuilder.Entity("EFCoreDemo.Models.CourseTag", b =>
                {
                    b.Property<int>("CourseId")
                        .HasColumnType("int");

                    b.Property<int>("TagId")
                        .HasColumnType("int");

                    b.HasKey("CourseId", "TagId");

                    b.HasIndex("TagId");

                    b.ToTable("CourseTag");

                    b.HasData(
                        new
                        {
                            CourseId = 1,
                            TagId = 1
                        },
                        new
                        {
                            CourseId = 7,
                            TagId = 1
                        },
                        new
                        {
                            CourseId = 8,
                            TagId = 1
                        },
                        new
                        {
                            CourseId = 3,
                            TagId = 1
                        },
                        new
                        {
                            CourseId = 2,
                            TagId = 1
                        },
                        new
                        {
                            CourseId = 2,
                            TagId = 5
                        },
                        new
                        {
                            CourseId = 4,
                            TagId = 3
                        },
                        new
                        {
                            CourseId = 9,
                            TagId = 3
                        },
                        new
                        {
                            CourseId = 5,
                            TagId = 2
                        },
                        new
                        {
                            CourseId = 6,
                            TagId = 4
                        });
                });

            modelBuilder.Entity("EFCoreDemo.Models.Tag", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .UseIdentityColumn();

                    b.Property<string>("Name")
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("Tags");

                    b.HasData(
                        new
                        {
                            Id = 1,
                            Name = "c#"
                        },
                        new
                        {
                            Id = 2,
                            Name = "angularjs"
                        },
                        new
                        {
                            Id = 3,
                            Name = "javascript"
                        },
                        new
                        {
                            Id = 4,
                            Name = "nodejs"
                        },
                        new
                        {
                            Id = 5,
                            Name = "oop"
                        },
                        new
                        {
                            Id = 6,
                            Name = "linq"
                        });
                });

            modelBuilder.Entity("EFCoreDemo.Models.Course", b =>
                {
                    b.HasOne("EFCoreDemo.Models.Author", "Author")
                        .WithMany("Courses")
                        .HasForeignKey("AuthorId");

                    b.HasOne("EFCoreDemo.Models.Category", "Category")
                        .WithMany()
                        .HasForeignKey("CategoryId");

                    b.Navigation("Author");

                    b.Navigation("Category");
                });

            modelBuilder.Entity("EFCoreDemo.Models.CourseTag", b =>
                {
                    b.HasOne("EFCoreDemo.Models.Course", "Course")
                        .WithMany("CourseTags")
                        .HasForeignKey("CourseId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("EFCoreDemo.Models.Tag", "Tag")
                        .WithMany("CourseTags")
                        .HasForeignKey("TagId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Course");

                    b.Navigation("Tag");
                });

            modelBuilder.Entity("EFCoreDemo.Models.Author", b =>
                {
                    b.Navigation("Courses");
                });

            modelBuilder.Entity("EFCoreDemo.Models.Course", b =>
                {
                    b.Navigation("CourseTags");
                });

            modelBuilder.Entity("EFCoreDemo.Models.Tag", b =>
                {
                    b.Navigation("CourseTags");
                });
#pragma warning restore 612, 618
        }
    }
}