#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

echo "--- Iniciando instalación total ---"

# 1. Instalar programas de los repositorios
echo "Instalando paquetes básicos..."
sudo apt update
sudo apt install -y bspwm sxhkd polybar rofi picom feh git curl

# 2. Instalar Zen Browser (descarga automática del instalador oficial)
if ! command -v zen &> /dev/null; then
    echo "Instalando Zen Browser..."
    bash <(curl -s https://raw.githubusercontent.com/zen-browser/desktop/main/install.sh)
else
    echo "Zen Browser ya está instalado."
fi

# 3. Configurar bspwm
mkdir -p "$HOME/.config/bspwm"
ln -sf "$DOTFILES_DIR/bspwm/bspwmrc" "$HOME/.config/bspwm/bspwmrc"

# 4. Configurar sxhkd
mkdir -p "$HOME/.config/sxhkd"
ln -sf "$DOTFILES_DIR/sxhkd/sxhkdrc" "$HOME/.config/sxhkd/sxhkdrc"

# 5. Configurar Zen (Aplicar tus prefs)
# Esperamos a que la carpeta del perfil se cree al abrirlo por primera vez
echo "Configurando perfil de Zen..."
ZEN_DIR="$HOME/.config/zen"
if [ -d "$ZEN_DIR" ]; then
    # Buscamos el perfil único
    PROFILE=$(find "$ZEN_DIR" -maxdepth 1 -name "*.Default*" | head -n 1)
    if [ -d "$PROFILE" ]; then
        ln -sf "$DOTFILES_DIR/zen/user.js" "$PROFILE/user.js"
        ln -sf "$DOTFILES_DIR/zen/user-overrides.js" "$PROFILE/user-overrides.js"
    fi
fi

echo "--- ¡Instalación completa! ---"
