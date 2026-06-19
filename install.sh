#!/bin/bash

# Directorio base (donde está este script)
DOTFILES_DIR="$HOME/dotfiles"

echo "Instalando configuraciones..."

# 1. Configurar bspwm
mkdir -p "$HOME/.config/bspwm"
ln -sf "$DOTFILES_DIR/bspwm/bspwmrc" "$HOME/.config/bspwm/bspwmrc"

# 2. Configurar sxhkd
mkdir -p "$HOME/.config/sxhkd"
ln -sf "$DOTFILES_DIR/sxhkd/sxhkdrc" "$HOME/.config/sxhkd/sxhkdrc"

# 3. Configurar Zen Browser (Buscamos la carpeta del perfil automáticamente)
ZEN_PROFILE_DIR=$(find "$HOME/.config/zen/" -maxdepth 1 -name "*.Default\ \(release\)" | head -n 1)
if [ -d "$ZEN_PROFILE_DIR" ]; then
    ln -sf "$DOTFILES_DIR/zen/user.js" "$ZEN_PROFILE_DIR/user.js"
    ln -sf "$DOTFILES_DIR/zen/user-overrides.js" "$ZEN_PROFILE_DIR/user-overrides.js"
    echo "Configuración de Zen aplicada en: $ZEN_PROFILE_DIR"
else
    echo "No se encontró el perfil de Zen. ¿Ya lo abriste al menos una vez?"
fi

# 4. Configurar bashrc
ln -sf "$DOTFILES_DIR/bashrc" "$HOME/.bashrc"

echo "¡Instalación completa! Reinicia tus servicios para ver los cambios."
