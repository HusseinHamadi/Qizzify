use `quizzify`;
-- Table for Admins
CREATE TABLE admins (
	admin_name VARCHAR(50) NOT NULL,
    admin_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL
);

-- Table for Teachers
CREATE TABLE teachers (
	teacher_name VARCHAR(50) NOT NULL,
    teacher_id INT PRIMARY KEY AUTO_INCREMENT,
    admin_id INT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    FOREIGN KEY (admin_id) REFERENCES admins(admin_id)
);

-- Table for Students
CREATE TABLE students (
	student_name VARCHAR(50) NOT NULL,
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL
);

-- Table for Exams
CREATE TABLE exams (
    exam_id INT PRIMARY KEY AUTO_INCREMENT,
    teacher_id INT,
    exam_name VARCHAR(100) NOT NULL,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id)
);

-- Table for Questions
CREATE TABLE questions (
    question_id INT PRIMARY KEY AUTO_INCREMENT,
    exam_id INT,
    score INT,
    question_text VARCHAR(255) NOT NULL,
    FOREIGN KEY (exam_id) REFERENCES exams(exam_id)
);

-- Table for Options
CREATE TABLE options (
    option_id INT PRIMARY KEY AUTO_INCREMENT,
    question_id INT,
    option_text VARCHAR(255) NOT NULL,
    is_correct BOOLEAN NOT NULL,
    FOREIGN KEY (question_id) REFERENCES questions(question_id)
);

-- Table for Student-Exam Attempt
CREATE TABLE student_exam_attempt (
    student_id INT,
    exam_id INT,
    score INT,
    PRIMARY KEY (student_id, exam_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (exam_id) REFERENCES exams(exam_id)
);

-- Table for Student-Question Attempt
CREATE TABLE student_question_attempt (
    student_id INT,
    question_id INT,
    selected_option_id INT,
    PRIMARY KEY (student_id, question_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (question_id) REFERENCES questions(question_id),
    FOREIGN KEY (selected_option_id) REFERENCES options(option_id)
);
