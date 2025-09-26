<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Documentation - Supercar</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
<style>
    body {
        font-family: 'Poppins', sans-serif;
        background: linear-gradient(135deg, #1a1a1a, #0d0d0d);
        color: #f1f1f1;
        margin: 0;
    }

    header {
        text-align: center;
        padding: 3rem 1rem;
        background-color: rgba(44,44,44,0.9);
        border-bottom: 4px solid #ffc107;
        backdrop-filter: blur(6px);
    }

    header h1 {
        color: #ffc107;
        font-size: 2.5rem;
        font-weight: 700;
        margin-bottom: 0.5rem;
    }

    header p {
        color: #ddd;
        font-size: 1.1rem;
    }

    .doc-list {
        max-width: 900px;
        margin: 3rem auto;
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 2rem;
        padding: 0 1rem;
    }

    .doc-item {
        background-color: #2c2c2c;
        border-radius: 12px;
        padding: 1.5rem;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        box-shadow: 0 8px 20px rgba(0,0,0,0.5);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .doc-item:hover {
        transform: translateY(-8px);
        box-shadow: 0 15px 30px rgba(0,0,0,0.7);
    }

    .doc-item span {
        font-size: 1.1rem;
        margin-bottom: 1rem;
        font-weight: 500;
    }

    .doc-item a {
        display: inline-block;
        text-align: center;
        padding: 0.6rem 1.2rem;
        font-weight: 600;
        border-radius: 6px;
        transition: all 0.3s ease;
        text-decoration: none;
    }

    .doc-item a:first-child {
        background-color: #ffc107;
        color: #1a1a1a;
        margin-bottom: 0.5rem;
    }

    .doc-item a:first-child:hover {
        background-color: #e6b800;
        transform: translateY(-2px);
    }

    .doc-item a:last-child {
        border: 2px solid #ffc107;
        color: #ffc107;
    }

    .doc-item a:last-child:hover {
        background-color: #ffc107;
        color: #1a1a1a;
        transform: translateY(-2px);
    }

    footer {
        text-align: center;
        padding: 2rem 1rem;
        color: #aaa;
        border-top: 1px solid #444;
        margin-top: 4rem;
    }

    @media (max-width: 576px) {
        .doc-list {
            grid-template-columns: 1fr;
        }
    }
</style>
</head>
<body>

<header>
    <h1>Documentation - Supercar</h1>
    <p>Tous les fichiers liés au projet Supercar</p>
</header>

<main class="doc-list">
    <div class="doc-item">
        <span>Contexte</span>
        <a href="contexte.pdf">Ouvrir</a>
    </div>
    <div class="doc-item">
        <span>Présentation</span>
        <a href="https://www.canva.com/design/DAGlw3w7c_U/g3625xIdjEVIAGmUP5XKdA/edit" >Ouvrir</a>
    </div>
</main>

<footer>
    &copy; 2025 Razafimahefa Lorryc | Tous droits réservés
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
