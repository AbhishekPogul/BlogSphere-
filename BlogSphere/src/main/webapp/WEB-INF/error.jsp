<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #ff7e5f, #feb47b);
            color: #fff;
            text-align: center;
            margin: 0;
            padding: 0;
        }
        .container {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
            padding: 20px;
        }
        h2 {
            font-size: 2.5rem;
            margin: 0;
            color: #fff;
            background: rgba(0, 0, 0, 0.6);
            padding: 10px 20px;
            border-radius: 10px;
        }
        p {
            font-size: 1.2rem;
            margin: 20px 0;
            background: rgba(0, 0, 0, 0.4);
            padding: 10px 20px;
            border-radius: 5px;
        }
        a {
            color: #fff;
            text-decoration: none;
            font-weight: bold;
            background: #007bff;
            padding: 10px 20px;
            border-radius: 5px;
            transition: background 0.3s;
        }
        a:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>An Error Occurred</h2>
        <p>Sorry, something went wrong. Please try again later.</p>
        <a href="/">Go Back to Home</a>
    </div>
</body>
</html>
