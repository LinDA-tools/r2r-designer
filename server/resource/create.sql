CREATE TABLE "Addresses" (
	"ID" INT,
	"city" VARCHAR(10),
	"state" CHAR(2),
  CONSTRAINT "C1" PRIMARY KEY("ID")
);

CREATE TABLE "Department" (
	"ID" INT,
	"name" VARCHAR(50),
  "city" VARCHAR(50),
	"manager" INT,
  CONSTRAINT "C2" PRIMARY KEY("ID"),
  CONSTRAINT "C3" UNIQUE ( "name", "city" )
);

CREATE TABLE "People" (
	"ID" INT PRIMARY KEY,
	"fname" VARCHAR(10),
	"addr" INT,
	"deptName" VARCHAR(50),
	"deptCity" VARCHAR(50),
	CONSTRAINT "C4" FOREIGN KEY ("addr") REFERENCES "Addresses"("ID")
);

ALTER TABLE "Department" ADD CONSTRAINT "C5" FOREIGN KEY("manager") REFERENCES "People"("ID");
ALTER TABLE "People" ADD CONSTRAINT "C6" FOREIGN KEY("deptName", "deptCity") REFERENCES "Department"("name", "city");

INSERT INTO "Addresses" ("ID", "city",      "state")
       VALUES (18,   'Cambridge', 'MA');

INSERT INTO "People" ("ID", "fname", "addr", "deptName", "deptCity" )
       VALUES (8,    'Sue',   NULL,   NULL,       NULL);

INSERT INTO "Department" ("ID", "name",       "city",      "manager")
       VALUES (23,   'accounting', 'Cambridge', 8);

INSERT INTO "People" ("ID", "fname", "addr", "deptName",   "deptCity" )
       VALUES (7,    'Bob',   18,     'accounting', 'Cambridge');
              
CREATE TABLE "Projects" (
	"lead" INT,
	"name" VARCHAR(50), 
	"deptName" VARCHAR(50), 
	"deptCity" VARCHAR(50),
	CONSTRAINT "C7" UNIQUE ("lead", "name"), 
	CONSTRAINT "C8" UNIQUE ("name", "deptName", "deptCity"),
	CONSTRAINT "C9" FOREIGN KEY ("deptName", "deptCity") REFERENCES "Department"("name", "city")
);
CREATE TABLE "TaskAssignments" (
	"worker" INT,
	"project" VARCHAR(50), 
	"deptName" VARCHAR(50), 
	"deptCity" VARCHAR(50),
	CONSTRAINT "C10" PRIMARY KEY ("worker", "project"),
	CONSTRAINT "C11" FOREIGN KEY ("project", "deptName", "deptCity") REFERENCES "Projects"("name", "deptName", "deptCity"),
	CONSTRAINT "C12" FOREIGN KEY ("deptName", "deptCity") REFERENCES "Department"("name", "city")
);

ALTER TABLE "Projects" ADD CONSTRAINT "C13" FOREIGN KEY("lead") REFERENCES "People"("ID");
ALTER TABLE "TaskAssignments" ADD CONSTRAINT "C14" FOREIGN KEY("worker") REFERENCES "People"("ID");

INSERT INTO  "Projects" ("lead", "name",          "deptName",   "deptCity" )
                 VALUES (8,      'pencil survey', 'accounting', 'Cambridge');
INSERT INTO  "Projects" ("lead", "name",          "deptName",   "deptCity" )
                 VALUES (8,      'eraser survey', 'accounting', 'Cambridge');
INSERT INTO "TaskAssignments" ("worker", "project",       "deptName",   "deptCity" )
                 VALUES (7,        'pencil survey', 'accounting', 'Cambridge');              
