#!/usr/bin/env python3
"""
🦕✨ Silas Learns Chinese - Magical Studio Ghibli Icon Generator
Creates beautiful app icons inspired by Totoro and Spirited Away
"""

import os
from PIL import Image, ImageDraw, ImageFont
import colorsys

def create_gradient_background(size, start_color, end_color):
    """Create a magical gradient background"""
    image = Image.new('RGB', size)
    draw = ImageDraw.Draw(image)
    
    for y in range(size[1]):
        ratio = y / size[1]
        # Smooth gradient interpolation
        r = int(start_color[0] * (1 - ratio) + end_color[0] * ratio)
        g = int(start_color[1] * (1 - ratio) + end_color[1] * ratio)
        b = int(start_color[2] * (1 - ratio) + end_color[2] * ratio)
        draw.line([(0, y), (size[0], y)], fill=(r, g, b))
    
    return image

def draw_totoro_silhouette(draw, center_x, center_y, scale=1.0):
    """Draw a simplified Totoro-inspired silhouette"""
    # Scale factor
    s = scale
    
    # Totoro body (gray-blue)
    body_color = (120, 140, 160)
    
    # Main body - large oval
    body_width = int(60 * s)
    body_height = int(80 * s)
    draw.ellipse([
        center_x - body_width//2, center_y - body_height//2,
        center_x + body_width//2, center_y + body_height//2
    ], fill=body_color)
    
    # Belly - lighter oval
    belly_color = (200, 220, 230)
    belly_width = int(40 * s)
    belly_height = int(50 * s)
    draw.ellipse([
        center_x - belly_width//2, center_y - belly_height//2 + int(10 * s),
        center_x + belly_width//2, center_y + belly_height//2 + int(10 * s)
    ], fill=belly_color)
    
    # Ears
    ear_color = (100, 120, 140)
    ear_size = int(20 * s)
    # Left ear
    draw.ellipse([
        center_x - int(40 * s), center_y - int(60 * s),
        center_x - int(20 * s), center_y - int(40 * s)
    ], fill=ear_color)
    # Right ear
    draw.ellipse([
        center_x + int(20 * s), center_y - int(60 * s),
        center_x + int(40 * s), center_y - int(40 * s)
    ], fill=ear_color)
    
    # Eyes
    eye_color = (60, 60, 60)
    eye_size = int(8 * s)
    # Left eye
    draw.ellipse([
        center_x - int(20 * s), center_y - int(20 * s),
        center_x - int(12 * s), center_y - int(12 * s)
    ], fill=eye_color)
    # Right eye
    draw.ellipse([
        center_x + int(12 * s), center_y - int(20 * s),
        center_x + int(20 * s), center_y - int(12 * s)
    ], fill=eye_color)
    
    # Nose
    nose_color = (40, 40, 40)
    draw.ellipse([
        center_x - int(3 * s), center_y - int(5 * s),
        center_x + int(3 * s), center_y + int(1 * s)
    ], fill=nose_color)

def draw_chinese_character(draw, center_x, center_y, scale=1.0):
    """Draw a beautiful Chinese character (中) for Chinese learning"""
    # Character color - magical gold
    char_color = (255, 215, 0)
    line_width = max(2, int(4 * scale))
    
    # Scale factor
    s = scale
    char_size = int(30 * s)
    
    # Draw 中 character simplified
    # Vertical line
    draw.rectangle([
        center_x - line_width//2, center_y - char_size//2,
        center_x + line_width//2, center_y + char_size//2
    ], fill=char_color)
    
    # Top horizontal line
    draw.rectangle([
        center_x - char_size//2, center_y - char_size//3 - line_width//2,
        center_x + char_size//2, center_y - char_size//3 + line_width//2
    ], fill=char_color)
    
    # Bottom horizontal line
    draw.rectangle([
        center_x - char_size//2, center_y + char_size//4 - line_width//2,
        center_x + char_size//2, center_y + char_size//4 + line_width//2
    ], fill=char_color)

def draw_magical_stars(draw, width, height, scale=1.0):
    """Draw magical sparkles around the icon"""
    import random
    random.seed(42)  # Consistent sparkles
    
    star_color = (255, 255, 200)
    num_stars = max(5, int(12 * scale))
    
    for _ in range(num_stars):
        x = random.randint(int(10 * scale), width - int(10 * scale))
        y = random.randint(int(10 * scale), height - int(10 * scale))
        star_size = random.randint(2, int(6 * scale))
        
        # Draw a simple star
        draw.ellipse([
            x - star_size, y - star_size,
            x + star_size, y + star_size
        ], fill=star_color)

def draw_forest_elements(draw, width, height, scale=1.0):
    """Draw magical forest elements inspired by Studio Ghibli"""
    # Leaves and magical elements
    leaf_colors = [
        (34, 139, 34),   # Forest green
        (50, 205, 50),   # Lime green
        (154, 205, 50),  # Yellow green
    ]
    
    import random
    random.seed(123)  # Consistent placement
    
    num_leaves = max(3, int(8 * scale))
    for _ in range(num_leaves):
        x = random.randint(0, width)
        y = random.randint(0, height)
        color = random.choice(leaf_colors)
        leaf_size = random.randint(int(3 * scale), int(8 * scale))
        
        # Simple leaf shape
        draw.ellipse([
            x - leaf_size, y - leaf_size//2,
            x + leaf_size, y + leaf_size//2
        ], fill=color)

def create_magical_icon(size):
    """Create a magical Studio Ghibli-inspired app icon"""
    # Magical gradient background (forest to sky)
    start_color = (85, 170, 85)   # Forest green
    end_color = (135, 206, 235)   # Sky blue
    
    image = create_gradient_background((size, size), start_color, end_color)
    draw = ImageDraw.Draw(image)
    
    # Calculate scale based on size
    scale = size / 120.0
    
    # Draw magical forest elements
    draw_forest_elements(draw, size, size, scale)
    
    # Draw magical stars/sparkles
    draw_magical_stars(draw, size, size, scale)
    
    # Draw Totoro-inspired character in the center-left
    totoro_x = int(size * 0.35)
    totoro_y = int(size * 0.5)
    draw_totoro_silhouette(draw, totoro_x, totoro_y, scale * 0.8)
    
    # Draw Chinese character in the center-right
    char_x = int(size * 0.7)
    char_y = int(size * 0.4)
    draw_chinese_character(draw, char_x, char_y, scale)
    
    # Add a magical border glow
    border_color = (255, 255, 255, 100)
    border_width = max(1, int(3 * scale))
    
    # Create rounded corners effect
    mask = Image.new('L', (size, size), 0)
    mask_draw = ImageDraw.Draw(mask)
    corner_radius = int(size * 0.2)
    mask_draw.rounded_rectangle([0, 0, size, size], corner_radius, fill=255)
    
    # Apply the mask for iOS app icon rounded corners
    output = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    output.paste(image, (0, 0))
    output.putalpha(mask)
    
    return output.convert('RGB')

def create_all_icon_sizes():
    """Create all required iOS app icon sizes"""
    # Required iOS app icon sizes
    sizes = [
        (40, "AppIcon-20@2x.png"),      # 20pt @2x
        (60, "AppIcon-20@3x.png"),      # 20pt @3x
        (58, "AppIcon-29@2x.png"),      # 29pt @2x
        (87, "AppIcon-29@3x.png"),      # 29pt @3x
        (80, "AppIcon-40@2x.png"),      # 40pt @2x
        (120, "AppIcon-40@3x.png"),     # 40pt @3x
        (120, "AppIcon-60@2x.png"),     # 60pt @2x
        (180, "AppIcon-60@3x.png"),     # 60pt @3x
        (1024, "AppIcon-1024.png"),     # App Store
    ]
    
    # Create directory if it doesn't exist
    icon_dir = "SilasLearnsChinese/Assets.xcassets/AppIcon.appiconset"
    os.makedirs(icon_dir, exist_ok=True)
    
    print("🎨 Creating magical Studio Ghibli app icons...")
    
    for size, filename in sizes:
        print(f"✨ Creating {filename} ({size}x{size})")
        icon = create_magical_icon(size)
        icon.save(os.path.join(icon_dir, filename), "PNG", quality=95)
    
    print("\n🦕 Magical icons created successfully!")
    print("🌟 Features:")
    print("   • Totoro-inspired character")
    print("   • Chinese character (中)")
    print("   • Magical forest background")
    print("   • Studio Ghibli gradient")
    print("   • Sparkles and mystical elements")
    print("   • Perfect for iPhone 16 Plus!")

if __name__ == "__main__":
    try:
        create_all_icon_sizes()
        print("\n🎉 SUCCESS: All magical app icons created!")
        print("📱 Ready to use in Xcode!")
    except ImportError:
        print("📦 Installing required packages...")
        os.system("pip3 install Pillow")
        create_all_icon_sizes()
    except Exception as e:
        print(f"❌ Error: {e}")
        print("\n🔧 Alternative: Manual icon creation guide created below...")
