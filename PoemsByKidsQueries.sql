--#1 What grades are stored in the database?
SELECT * FROM Grade;

--#2 What emotions may be associated with a poem?
SELECT * FROM Emotion;

--#3 How many poems are in the database?
SELECT COUNT(Id) AS 'Number of Poems'
FROM Poem;

--#4 Sort authors alphabetically by name. What are the names of the top 76 authors?
SELECT TOP 76 Name
FROM Author a
ORDER BY a.Name;

--#5 Starting with the above query, add the grade of each of the authors.
SELECT TOP 76 a.Name, g.Name
FROM Author a
JOIN Grade g On g.Id = a.GradeId
ORDER BY a.Name;

--#6 Starting with the above query, add the recorded gender of each of the authors.
SELECT TOP 76 a.Name, g.Name AS Grade, ge.Name AS Gender
FROM Author a
JOIN Grade g ON g.Id = a.GradeId
JOIN Gender ge ON ge.Id = a.GenderId
ORDER BY a.Name;

--#7 What is the total number of words in all poems in the database?
SELECT SUM(WordCount) AS 'All the Words'
FROM Poem;

--#8 Which poem has the fewest characters?
SELECT TOP 1 *
FROM Poem
ORDER BY CharCount;

--#9 How many authors are in the third grade?
SELECT COUNT(a.Id) AS 'Number of 3rd Graders'
FROM Author a
LEFT JOIN Grade g ON g.Id= a.GradeId
WHERE g.Name = '3rd Grade';

--#10 How many total authors are in the first through third grades?
SELECT COUNT(a.Id) AS 'Number of Students in 1st - 3rd Grade'
FROM Author a
LEFT JOIN Grade g ON g.Id= a.GradeId
WHERE g.Name = '3rd Grade' OR g.Name = '1st Grade' OR g.Name = '2nd Grade'

--#11 What is the total number of poems written by fourth graders?
SELECT COUNT(p.Id) AS 'Number of 4th Grade Poems'
FROM Poem p
LEFT JOIN Author a on a.id = p.AuthorId
LEFT JOIN Grade g ON g.id = a.GradeId
WHERE g.Name = '4th Grade';

--#12 How many poems are there per grade?
SELECT COUNT(p.Id) AS 'Number of Poems by Grade', g.Name
FROM Poem p
LEFT JOIN Author a on a.id = p.AuthorId
LEFT JOIN Grade g ON g.id = a.GradeId
GROUP BY g.Id, g.Name;

--#13 How many authors are in each grade? (Order your results by grade starting with 1st Grade)
SELECT COUNT(a.Id) AS 'Authors per Grade', g.Name
FROM Author a
LEFT JOIN Grade g ON g.Id = a.GradeId
GROUP BY g.Name, g.Id
ORDER BY g.Id

--#14 What is the title of the poem that has the most words?
SELECT TOP 1 p.Title
FROM Poem p
ORDER BY p.WordCount DESC;

--#15 Which author(s) have the most poems? (Remember authors can have the same name.)
SELECT DISTINCT a.Name, COUNT(p.AuthorId) AS NumberOfPoems
FROM Poem p
LEFT JOIN Author a ON a.Id = p.AuthorId
GROUP BY a.Name, a.Id
ORDER BY NumberOfPoems DESC

--#16 How many poems have an emotion of sadness?
SELECT COUNT(p.Id) AS 'Number of Sad Poems'
FROM Poem p
LEFT JOIN PoemEmotion pe ON pe.PoemId = p.Id
LEFT JOIN Emotion e ON e.Id = pe.EmotionId
WHERE e.Name = 'Sadness';

--#17 How many poems are not associated with any emotion?
SELECT COUNT(p.Id) AS 'Emotionless Poems'
FROM Poem p
LEFT JOIN PoemEmotion pe ON pe.PoemId = p.Id
LEFT JOIN Emotion e ON e.Id = pe.EmotionId
WHERE e.Name IS NULL;

--#18 Which emotion is associated with the least number of poems?
SELECT TOP 1 e.Name AS 'Emotion with the least number of poems:'
FROM Poem p
JOIN PoemEmotion pe ON pe.PoemId = p.Id
JOIN Emotion e ON e.Id = pe.EmotionId
GROUP BY e.Id, e.Name
ORDER BY e.Name;

--#19 Which grade has the largest number of poems with an emotion of joy?
SELECT COUNT(p.Id) AS 'Joyful Poems by Grade', g.Name AS Grade, e.Name AS EmotionName
FROM Poem p
LEFT JOIN PoemEmotion pe ON pe.PoemId = p.Id
LEFT JOIN Emotion e ON e.Id = pe.EmotionId
LEFT JOIN Author a ON a.Id = p.AuthorId
LEFT JOIN Grade g ON g.Id = a.GradeId
GROUP BY g.Id, g.Name, e.Name
HAVING e.Name = 'Joy'
ORDER BY 'Joyful Poems by Grade' DESC; 

--#20 Which gender has the least number of poems with an emotion of fear?
SELECT COUNT(p.Id) AS 'Fearful Poems by Gender', ge.Name AS Gender
FROM Poem p
LEFT JOIN PoemEmotion pe ON pe.PoemId = p.Id
LEFT JOIN Emotion e ON e.Id = pe.EmotionId
LEFT JOIN Author a ON a.Id = p.AuthorId
LEFT JOIN Gender ge ON ge.Id = a.GenderId
GROUP BY ge.Id, ge.Name, e.Name
HAVING e.Name = 'Fear'
ORDER BY 'Fearful Poems by Gender';