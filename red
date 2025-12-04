<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Knight and Princess Animation</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: #000;
            font-family: Arial, sans-serif;
        }
        canvas {
            display: block;
            background: #000;
        }
    </style>
</head>
<body>
    <canvas id="canvas" width="800" height="400"></canvas>

    <script>
        const canvas = document.getElementById('canvas');
        const ctx = canvas.getContext('2d');

        let animationId;
        let knightX = 50;
        let princessX = 700;
        let phase = 'running';
        let frame = 0;
        let kissTimer = 0;

        // Draw shadow
        function drawShadow(x, y) {
            ctx.fillStyle = 'rgba(0, 0, 0, 0.3)';
            ctx.beginPath();
            ctx.ellipse(x, y + 32, 12, 4, 0, 0, Math.PI * 2);
            ctx.fill();
        }

        // Draw knight (inspired by pixel art style with aerial angle)
        function drawKnight(x, y, legOffset = 0) {
            drawShadow(x, y);
            
            // Legs (back leg) - dark gray - positioned more to back due to angle
            ctx.fillStyle = '#505050';
            ctx.fillRect(x - 4, y + 14 + legOffset, 3, 6);
            ctx.fillStyle = '#303030';
            ctx.fillRect(x - 4, y + 20 + legOffset, 4, 4);
            
            // Legs (front leg) 
            ctx.fillStyle = '#606060';
            ctx.fillRect(x + 2, y + 16 - legOffset, 3, 6);
            ctx.fillStyle = '#404040';
            ctx.fillRect(x + 2, y + 22 - legOffset, 4, 4);
            
            // Body/Torso - armor - slightly wider at top for depth
            ctx.fillStyle = '#B0B0B0';
            ctx.fillRect(x - 6, y + 2, 12, 14);
            
            // Armor detail
            ctx.fillStyle = '#D0D0D0';
            ctx.fillRect(x - 5, y + 3, 10, 4);
            
            // Arms - angled outward
            ctx.fillStyle = '#A0A0A0';
            ctx.fillRect(x - 8, y + 4, 3, 10);
            ctx.fillRect(x + 5, y + 4, 3, 10);
            
            // Shield on left arm
            ctx.fillStyle = '#2E5C8A';
            ctx.fillRect(x - 9, y + 6, 4, 7);
            ctx.fillStyle = '#FFD700';
            ctx.fillRect(x - 8, y + 8, 2, 2);
            
            // Neck
            ctx.fillStyle = '#FFDAB9';
            ctx.fillRect(x - 2, y - 1, 4, 3);
            
            // Head - slightly elongated for angle
            ctx.fillStyle = '#FFE4C4';
            ctx.fillRect(x - 4, y - 9, 8, 9);
            
            // Hair - showing top of head
            ctx.fillStyle = '#8B4513';
            ctx.fillRect(x - 5, y - 10, 10, 3);
            
            // Helmet sides
            ctx.fillStyle = '#909090';
            ctx.fillRect(x - 6, y - 7, 2, 7);
            ctx.fillRect(x + 4, y - 7, 2, 7);
            
            // Plume - more visible from top
            ctx.fillStyle = '#DC143C';
            ctx.fillRect(x - 1, y - 12, 3, 3);
            ctx.fillRect(x, y - 13, 2, 2);
            
            // Eyes - angled down
            ctx.fillStyle = '#000';
            ctx.fillRect(x - 2, y - 5, 1, 1);
            ctx.fillRect(x + 1, y - 5, 1, 1);
        }

        // Draw princess (inspired by pixel art style with aerial angle)
        function drawPrincess(x, y, legOffset = 0) {
            drawShadow(x, y);
            
            // Legs (back leg) - positioned more to back
            ctx.fillStyle = '#F4C2C2';
            ctx.fillRect(x - 3, y + 14 + legOffset, 3, 6);
            ctx.fillStyle = '#FFD700';
            ctx.fillRect(x - 3, y + 20 + legOffset, 4, 4);
            
            // Legs (front leg)
            ctx.fillRect(x + 1, y + 16 - legOffset, 3, 6);
            ctx.fillRect(x + 1, y + 22 - legOffset, 4, 4);
            
            // Dress - main body - wider at bottom, showing depth
            ctx.fillStyle = '#FF69B4';
            ctx.fillRect(x - 7, y + 2, 14, 14);
            
            // Dress highlight
            ctx.fillStyle = '#FF8DC7';
            ctx.fillRect(x - 6, y + 3, 5, 12);
            
            // Bodice
            ctx.fillStyle = '#FFB6D9';
            ctx.fillRect(x - 5, y, 10, 6);
            
            // Arms - angled outward
            ctx.fillStyle = '#FFDAB9';
            ctx.fillRect(x - 7, y + 4, 2, 8);
            ctx.fillRect(x + 5, y + 4, 2, 8);
            
            // Neck
            ctx.fillStyle = '#FFE4C4';
            ctx.fillRect(x - 2, y - 1, 4, 2);
            
            // Head - slightly elongated for angle
            ctx.fillRect(x - 4, y - 9, 8, 9);
            
            // Hair - showing top and sides more
            ctx.fillStyle = '#FFD700';
            ctx.fillRect(x - 6, y - 10, 12, 8);
            ctx.fillRect(x - 5, y - 1, 10, 2);
            
            // Crown - more visible from top
            ctx.fillStyle = '#FFA500';
            ctx.fillRect(x - 5, y - 13, 10, 3);
            ctx.fillStyle = '#FFD700';
            ctx.fillRect(x - 4, y - 14, 2, 2);
            ctx.fillRect(x + 2, y - 14, 2, 2);
            
            // Eyes - angled down
            ctx.fillStyle = '#000';
            ctx.fillRect(x - 2, y - 5, 1, 1);
            ctx.fillRect(x + 1, y - 5, 1, 1);
            
            // Smile
            ctx.fillRect(x - 1, y - 3, 2, 1);
        }

        // Draw heart (pixel style)
        function drawHeart(x, y) {
            ctx.fillStyle = '#FF1493';
            ctx.fillRect(x - 6, y, 4, 4);
            ctx.fillRect(x + 2, y, 4, 4);
            ctx.fillRect(x - 8, y + 4, 16, 4);
            ctx.fillRect(x - 6, y + 8, 12, 4);
            ctx.fillRect(x - 4, y + 12, 8, 4);
            ctx.fillRect(x - 2, y + 16, 4, 4);
        }

        function animate() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            
            frame++;
            const legOffset = Math.floor(Math.sin(frame * 0.3) * 2);

            if (phase === 'running') {
                knightX += 3;
                drawKnight(knightX, 180, legOffset);
                drawPrincess(princessX, 180, 0);
                
                if (knightX >= princessX - 40) {
                    phase = 'kissing';
                    kissTimer = 0;
                }
            } else if (phase === 'kissing') {
                drawKnight(knightX, 180, 0);
                drawPrincess(princessX, 180, 0);
                
                // Draw hearts
                const heartY = 120 - Math.floor(Math.sin(kissTimer * 0.1) * 10);
                drawHeart(knightX + 20, heartY);
                drawHeart(princessX - 20, heartY - 15);
                
                kissTimer++;
                if (kissTimer >= 90) {
                    phase = 'returning';
                }
            } else if (phase === 'returning') {
                knightX -= 4;
                princessX -= 4;
                drawKnight(knightX, 180, legOffset);
                drawPrincess(princessX, 180, legOffset);
                
                if (knightX <= -50) {
                    // Reset and loop
                    knightX = 50;
                    princessX = 700;
                    phase = 'running';
                    frame = 0;
                    kissTimer = 0;
                }
            }

            animationId = requestAnimationFrame(animate);
        }

        // Start automatically
        animate();
    </script>
</body>
</html>
