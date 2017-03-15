#!/usr/bin/ruby

require 'gtk3'
require 'gdk3'

Gtk.init

class Case < Gtk::DrawingArea

    attr_accessor :x, :y, :largeur, :hauteur, :taillePolice

    def initialize nombre

        super()
        
        @largeur = 40
        @hauteur = 40

        @x = 0
        @y = 0

        @taillePolice = @largeur / 3

        @nombre = nombre
        
        ## Crée la zone de dessin au signal draw
        signal_connect "draw" do  |widget, cr|
            dessiner cr
        end

        ## Ajoute un évènement (signal) à saisir ici c'est l'appui sur un bouton de la souris
        add_events(Gdk::EventMask::BUTTON_PRESS_MASK)

        ## Lie un callback sur la souris
        signal_connect "button_press_event" do |widget, evenement|
            clicSouris evenement
        end

    end

    ##
    ## @brief      Callback sur l'appui sur la souris (évènement ajouté à la main)
    ##
    ## @return
    ##
    def clicSouris evenement

        if evenement.button == 1
            puts "left click pressed"
        elsif evenement.button == 2
            puts "middle click pressed"
        elsif evenement.button == 3
            puts "right click pressed"
        end

        return self
    end

    ##
    ## @brief      Dessine une case
    ##
    ##
    def dessiner cr

        set_size_request(@largeur, @hauteur)

        ## Définis la couleur pour le dessin (ici blanc)
        cr.set_source_rgb 1.0, 1.0, 1.0

        ## Dessine un rectangle
        cr.rectangle @x, @y, @largeur, @hauteur
        cr.fill

        ## Définis une nouvelle couleur (ici noire)
        cr.set_source_rgb 0.0, 0.0, 0.0

        ## Définis les caractéristiques du texte
        cr.select_font_face "Arial", 
            Cairo::FONT_SLANT_NORMAL, Cairo::FONT_WEIGHT_NORMAL
        cr.set_font_size @taillePolice

        extents = cr.text_extents @nombre
        cr.move_to @x + @largeur / 2 - extents.width / 2, @y + @hauteur / 2 + extents.height / 2 ## Déplace le curseur de texte au centre de la case
        cr.show_text @nombre

        cr.set_source_rgb 0.5, 0.5, 0.5

        cr.move_to @x , @y
        cr.set_line_width 0.5

        ## Calcule le chemin du contour de la case
        cr.rel_line_to @largeur, 0
        cr.rel_line_to 0, @hauteur
        cr.rel_line_to -@largeur, 0
        cr.rel_line_to 0, -@hauteur

        cr.stroke

        return self

    end

end

class Grille < Gtk::Grid

    def initialize valeurs
        
        super() 

        ## TODO: Lire largeur et hauteur dans un fichier de config
        @largeurCase = 40 
        @hauteurCase = 40
        
        @valeurs     = valeurs        
        @cases       = Array.new()
        @nbCases     = 9

        signal_connect "draw" do |widget, cr|
            dessiner cr
        end

        colonne = 0
        ligne   = 0

        largeurCol = 1
        hauteurLig = 1

        @valeurs.each do | section |
            
            section.each do |valeur |
                c = Case.new valeur
                @cases << c

                attach c, colonne, ligne , largeurCol, hauteurLig

                if colonne == 8
                    colonne  = 0
                    ligne   += 1 
                else
                    colonne += 1
                end
            end

        end
    end

    def dessiner cr

        ## TODO: Définir une largeur de case et fenêtre par défaut chargé
        ## à partir d'un fichier de config en variables d'instances
        @largeurCase = (25 * toplevel.allocated_width  / 600).round
        @hauteurCase = @largeurCase

        colonne = 0
        ligne   = 0

        @cases.each do | c |

            c.largeur = @largeurCase
            c.hauteur = @hauteurCase
            c.taillePolice = @largeurCase / 3

            c.x = colonne * @largeurCase
            c.y = ligne * @hauteurCase
            c.dessiner cr

            if colonne == 8
                colonne  = 0
                ligne   += 1 
            else
                colonne += 1
            end
        end

        largeurLigne = @nbCases * @largeurCase
        hauteurLigne = @nbCases * @hauteurCase
        
        set_size_request largeurLigne , hauteurLigne

        largeurBordureExt = 4

        cr.set_source_rgb 0.0 , 0.0, 0.0

        ## Calcule le chemin du contour
        cr.move_to 0, 0
        cr.set_line_width largeurBordureExt

        cr.rel_line_to largeurLigne, 0
        cr.rel_line_to 0, hauteurLigne
        cr.rel_line_to -largeurLigne, 0
        cr.rel_line_to 0, -hauteurLigne

        ## Calcule le chemin des délimitations
        cr.move_to 3 * @largeurCase, 0
        cr.rel_line_to 0, hauteurLigne

        cr.move_to 6 * @largeurCase, 0
        cr.rel_line_to 0, hauteurLigne

        cr.move_to 0, 3 * @hauteurCase
        cr.rel_line_to largeurLigne, 0

        cr.move_to 0, 6 * @hauteurCase
        cr.rel_line_to largeurLigne, 0

        ## Dessine les lignes à partir des chemins calculés précédemment
        cr.stroke

        return self
    end

end

class RubyApp < Gtk::Window

    def initialize
        super
    
        set_title "TestGrille"
        
        signal_connect "destroy" do 
            Gtk.main_quit 
        end

        grille = Grille.new(
            [
            ["", "2", "3", "1", "2", "", "1", "", "3"], 
            ["4", "", "6", "4", "5", "6", "4", "5", "6"], 
            ["7", "8", "9", "7", "8", "9", "7", "8", "9"],
            ["1", "2", "", "1", "2", "", "1", "2", "3"], 
            ["4", "5", "6", "4", "5", "", "", "5", "6"], 
            ["7", "", "9", "7", "8", "9", "7", "8", ""],
            ["1", "2", "3", "1", "2", "3", "", "2", "3"], 
            ["", "5", "6", "4", "", "6", "4", "5", ""], 
            ["7", "8", "", "7", "8", "9", "7", "8", "9"]
            ]
        )

        fixed   = Gtk::Fixed.new 

        fixed.put grille, 120, 120
        add fixed

        set_default_size 600, 600
        set_window_position :center
         
        show_all
    end
    
end

RubyApp.new

Gtk.main