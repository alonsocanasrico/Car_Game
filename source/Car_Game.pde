//NOTA: "COCHE2", A VECES LLAMADO COCHE AMARILLO, Y "MOTO" SON LOS VEHÍCULOS QUE VIENEN POR A PANTALLA QUE HAY QUE ESQUIVAR. A PESAR DE QUE SE LLAMEN MOTO Y COCHE NO SIGNIFICA QUE SEAN UNA MOTO Y UN COCHE NECESARIAMENTE
//      YA QUE LA IMAGEN QUE LES CORRESPONDE SE ELIGE DE MANERA ALEATORIA CADA VEZ QUE APARECEN POR PANTALLA, DE MODO QUE EN OCASIONES LA "MOTO" PODRÍA MOSTRARSE COMO UN COCHE Y VICEVERSA


//importa la librería de sonido
import ddf.minim.*;
Minim soundengine;
//crea dos variables para los dos sonidos que se utilizan
AudioSample choque;
AudioSample musica;
//crea 11 variables que serán las imágenes utilizadas en en programa
PImage moto;
PImage coche;
PImage coche2;
PImage fondo;
PImage camion;
PImage barril;
PImage barril2;
PImage inicio;
PImage boom;
PImage adorno1;
PImage adorno2;
//crea dos variables, que determinan la posición del coche que se mueve con el ratón. El valor inicial de la posición vertical es indiferente ya que la posición del coche viene determinada por la posición del ratón
float cocheY = 500;
float cocheX = 300;
//crea 4 variables que servirán a modo de "velocidad" del coche , de la moto, del barril, del camión y de los adornos que vengan
float velocidadC; //velocidad del coche amarillo
float velocidadM; //velocidad de la moto
float velocidadB; //velocidad del barril
float velocidadCam; //velocidad del camión
float velocidadA; // velocidad de los adornos
//crea dos variables de tipo lógico, de modo que detectan cuando la moto o el coche han llegado al final de la pantalla
boolean finalcoche2;
boolean finalmoto;
//lo mismo para los adornos
boolean finaladorno1;
boolean finaladorno2;
//lo mismo para los barriles
boolean finalbarril;
boolean finalbarril2;
//crea las variables de posición del coche amarillo, de la moto, del camión, del barril y de los adornos
float coche2Y;
float coche2X;
float motoY;
float motoX;
float camionY;
float camionX;
float barrilX;
float barrilY;
float barril2X;
float barril2Y;
float adorno1X;
float adorno1Y;
float adorno2X;
float adorno2Y;
//crea una variable que cuenta la puntuación que va consiguiendo el jugador
int puntuacion;
//crea una variable lógica que detecta cuando se acaba la partida
boolean finjuego;
//crea otra variable lógica de valor falso para cuando el coche rojo (jugador) colisione con otro coche, moto, o barril. (No puede colisionar con los adornos porque su función es meramente estética)
boolean chocar;
//crea otra serie de variables lógicas, que cuando se llegue a determidada puntuación se harán de valor verdadero para que aparezca un camión que lance barriles en pantalla
boolean haycamion;
boolean haybarril;
boolean haybarril2;
//crea dos variables lógicas, para que el camión se desplace automáticamente de arriba-abajo por la pantalla
boolean subir;
boolean bajar;
//variable lógica para que comience la partida
boolean jugar;


void setup()
{
  //crea un lienzo de pantalla completa
  fullScreen();
  //carga al programa todas las imágenes que se utilizan
  coche = loadImage("coche.png");
  coche2 = loadImage("coche2.png");
  moto = loadImage("moto.png");
  fondo = loadImage("fondo.png");
  camion = loadImage("camion.png");
  barril = loadImage("barril.png");
  barril2 = loadImage("barril2.png");
  inicio = loadImage("gameover.jpg");
  boom = loadImage("explosion.png");
  //carga al programa los sonidos
  soundengine = new Minim(this);
  choque = soundengine.loadSample("choque.mp3",1024);
  soundengine = new Minim(this);
  musica = soundengine.loadSample("Musica.mp3",1024);
  //se reproduce la música de fondo
  musica.trigger();
  //se declaran los valores iniciales de las variables
  //posción del coche que conntrola el jugador
  cocheY = 500;
  cocheX = 300;
  velocidadC = 20; //velocidad del coche amarillo
  velocidadM = 17; //velocidad de la moto
  velocidadB = 22; //velocidad del barril
  velocidadCam = 7; //velocidad del camión
  velocidadA = 18.5; //velocidad de los adornos
  //variables que detectan cuando un objeto llega a la izquierda de la pantalla
  finalcoche2 = true;
  finalmoto = true;
  finalbarril = true;
  finalbarril2 = true;
  finaladorno1 = true;
  finaladorno2 = true;
  //variables de posición del coche amarillo, de la moto, del camión, del barril y de los adornos
  coche2Y = random(height-115);
  coche2X = width;
  motoY = random(height-115);
  motoX = width;
  camionY = height/2 - 150;
  camionX = width;
  //los barriles aparecen fuera de pantalla en un inicio, porque no intervienen en el juego hasta más adelante
  barrilX = -200;
  barrilY = -200;
  barril2X = -200;
  barril2Y = -200;
  adorno1X = width;
  adorno1Y = 1;
  adorno2X = width/2;
  adorno2Y = height-151;
  //variable que cuenta la puntuación que va consiguiendo el jugador
  puntuacion = 0;
  //variable lógica de valor falso, que se hará verdadera cuando el juego haya terminado
  finjuego = false;
  //variable lógica de valor falso para cuando el coche rojo (jugador) colisione con otro coche, moto, o barril
  chocar = false;
  //variable lógica de valor falso, que cuando se llegue a determidada puntuación se hará de valor verdadero para que aparezca un camion que tira barriles en pantalla
  haycamion = false;
  haybarril = false;
  haybarril2 = false;
  //el camión comienza subiendo
  subir = false;
  bajar = true;
  //variable lógica de valor falso que se hará verdadera al hacer click con el ratón y empezar la partida
  jugar = false;
  //se ajusta el tamaño de la imagen de fondo al tamaño de la pantalla
  fondo.resize(width,height);
  inicio.resize(width,height);
}

void draw()
{ 
  //al comenzar el programa, aparece un menú de inicio, y al hacer click con el ratón comienza el juego
  if(jugar == false);
  { 
    image(inicio,0,0);
    textSize(120);
    fill(247,114,25);
    text("NEED FOR SPEED", width / 2 - 475, height/2 - 200);
    textSize(75);
    text("GAME OF THE YEAR EDITION", width / 2 - 500, height/2);
    textSize(50);
    text("Haz click para jugar", width/2 - 200, height/2 + 200);
    if(mousePressed)
    {
      jugar = true;
    }
  }
  
  //tras haber hecho click, la variable jugar se ha vuelto devalor verdadero, y comienza la partida
  if(jugar == true)
  {
    
    
  //la imagen de fondo aparece en pantalla
  
  image(fondo,0,0);
  
  //adornos que dan sensación de movimiento
  //cuando el adorno 1 llega al final, su image se cambia aleatoriamente por otra imagen de adorno (en función del valor aleatorio random(1,5). Hay 4 opciones, 3 son arbustos distintos, y otra son unas piedras
  if(finaladorno1)
  {
   switch(int(random(1,5))){
      case 1:
             adorno1 = loadImage("arbusto1.png"); 
             break;
      case 2:
             adorno1 = loadImage("arbusto2.png"); 
             break;
      case 3:
             adorno1 = loadImage("arbusto3.png"); 
             break;
      case 4:
             adorno1 = loadImage("piedras.png");
             break;
   
   }
   finaladorno1 = false; // la variable que detecta si ha llegado al final se vuelve falsa, ya que la imagen ha vuelto al principio
  }
  if(finaladorno2)//lo mismo de antes pero para el adorno 2
  {
   switch(int(random(1,5))){
      case 1:
             adorno2 = loadImage("arbusto1.png"); 
             break;
      case 2:
             adorno2 = loadImage("arbusto2.png"); 
             break;
      case 3:
             adorno2 = loadImage("arbusto3.png"); 
             break;
      case 4:
             adorno2 = loadImage("piedras.png");
             break;
   }    
   finaladorno2 = false;
  }
  //ambos adornos se desplazan por la pantalla de derecha a izquierda, restando a sus coordenadas horizontales (x) el valor de una variable llamada velocidad, que aumenta con el tiempo; de esta manera cada vez se resta un  valor mayor a su coordenada X y se desplazan más rápido
  adorno1X = adorno1X - velocidadA;
  adorno2X = adorno2X - velocidadA;
  //aparecen las imágenes de ambos adornos en pantalla
  image(adorno1,adorno1X,adorno1Y, 150, 150);
  image(adorno2, adorno2X, adorno2Y, 150, 150);
  
  if(adorno1X<(-150)) // cuando el adorno se sale de la pantalla (llega al final), vuelve al principio y la variable que lo detecta se vuelve de valor verdadero
  {
    adorno1X = width;
    finaladorno1 = true;
  }
  if(adorno2X<(-150)) // lo mismo para el adorno 2
  {
    adorno2X = width;
    finaladorno2 = true;
  }
  //cuando el coche amarillo llega al final, vuelve a la derecha de la pantalla
  if(finalcoche2)
  {
    if(puntuacion >= 31) // si la puntuación es mayor o igual a 31 (cuando aparece el camión, la variable finalcoche2 sigue siendo falsa, de este modo el coche no vuelve al principio, cosa que no es necesaria porque ya se ha pasado a la fase del camión
    {
      finalcoche2 = false;
    }
    switch(int(random(1,5))) // su imagen cambia aleatoriamente a la imagen de otro coche de otro color, o a la de una moto (el procedimiento es el mismo que el que se usó para las imágenes de los adornos
    {
      case 1:
             coche2 = loadImage("cocheazul.png"); 
             break;
      case 2:
             coche2 = loadImage("cocheverde.png"); 
             break;
      case 3:
             coche2 = loadImage("coche2.png"); 
             break;
      case 4:
             coche2 = loadImage("moto.png"); 
    }
    
    coche2Y = random(0, (height-115)); // la altura (coordenada Y) del coche se elige aleatoriamente para cualquier altura de la pantalla (pone -115 porque es lo que mide la imagen, de este modo no aparece fuera de la pnatalla
    //para que la moto y el coche 2 no aparezcan en la misma posición
    if(abs(motoY - coche2Y) < 115) //si la altura de la pantalla a la que se encuentra el coche amarillo es la misma o está muy cerca de la moto, se desplaza 350 hacia arriba, de esta manera no aparecerá una imagen encima de la otra
    {
      coche2Y = coche2Y - 350;
      if(coche2Y < 0)  //si tras desplazarse 350 hacia arriba, el coche amarillo se saliese de la pantalla, se desplazaria 700 hacia abajo, de este modo es seguro que no se sale de la pantalla ni toca a la moto
      {
        coche2Y = coche2Y + 700;
      }
    }
    finalcoche2 = false;
  }
  // todo el sigueinte bloque If es igual que el anterior, pero para el otro vehículo que viene (la variable de este se llama moto pero su imagen puede ser una moto o un coche, aleatoriamente elegido)
  if(finalmoto) 
  {
    if(puntuacion >= 31)
    {
      finalmoto = false;
    }
    switch(int(random(1,5))) 
    {
      case 1:
             moto = loadImage("cocheazul.png"); 
             break;
      
      case 2:
             moto = loadImage("cocheverde.png"); 
             break;
      case 3:
             moto = loadImage("coche2.png"); 
             break;
      case 4:
             moto = loadImage("moto.png"); 
    }
    
    motoY = random(0, (height-115));
    if(abs(motoY - coche2Y)< 115)
    {
      motoY = motoY - 350;
      if(motoY < 0)
      {
        motoY = motoY + 700;
      }
    }
    finalmoto = false;
  }
  
 
  //se asigna la posición vertical del coche a la posición vertical del ratón -57'5 que es la mitad de la altura del coche (para que el ratón quede a la mitad de la imagen del coche)
  if((mouseY < (height-57.5)) & (mouseY > 57.5))
  {
    cocheY = mouseY - 57.5;
  }
  if(mouseY > (height-57.5)) //si el ratón se pone en el borde superior de la pantalla, el coche se quderá dentro de esta, y no se saldrá la mitad de la imagen por fuera
  {
    cocheY = height - 115;
  }
  if(mouseY < 57.5)  //si el ratón se pone en el borde inferior de la pantalla, el coche se quderá dentro de esta, y no se saldrá la mitad de la imagen por fuera
  {
    cocheY = 0;
  }
  
  //aparecen las imágenes de la moto, del coche amarillo, y del coche rojo en sus posiciones respectivas
  image(moto, motoX, motoY, 175, 115);
  image(coche2, coche2X, coche2Y, 175, 115);
  image(coche,cocheX,cocheY,175,115);
  
  //se cambia la posición horizontal del coche amarillo y de la moto, restando a su posición actual un valor determinado por las variables de velocidad
  coche2X = coche2X - velocidadC;
  motoX = motoX - velocidadM;
  
  //muestra la puntuación por pantalla
  textSize(32);
  text(puntuacion, width/2, height/15);
  
  if(coche2X < -175)  //si el coche amarillo llega al final, vuelve a la derecha del todo y se suma un punto a la puntuación total
  {
    finalcoche2 = true;
    coche2X = width;
    puntuacion = puntuacion + 1;
  }
  
  if(motoX < -175)  //si la moto llega al final, vuelve a la derecha del todo y se suma un punto a la puntuación total
  {
    finalmoto = true;
    motoX = width;
    puntuacion = puntuacion + 1;
  }
  
  if((puntuacion % 5) == 0 & puntuacion > 4 & finalcoche2 == true) //cada 5 puntos, las velocidades del coche amarillo y de la moto se incrementan, de esta manera el juego es más difícil conforme se va avanzando y haciendo más puntos
  {
    velocidadC = velocidadC + 8;
    velocidadM = velocidadM + 6;
  }
  
  if((puntuacion % 3) == 0 & puntuacion > 31 & finalbarril == true) //cada 3 puntos, a partir de los 31, que es cuando se pasa ala fase del camión, la velocidad del barril y del camión aumentan
  {
    velocidadB = velocidadB + 4;
    velocidadCam = velocidadCam + 5;
  }
  if((puntuacion % 4) == 0 & finaladorno1) // cada 4 puntos la velocidad de los adornos aumenta, para dar sensación de movimiento en el juego
  {
    velocidadA = velocidadA + 5;
  }
  
  if(puntuacion >= 31 & finalcoche2 == false & finalmoto == false) // al llegar a 31 puntos, se pasa a la fase del camión, para ello la moto y el coche se detienen y desaparecen de la pantalla
  {
    velocidadC = 0;
    velocidadM = 0;
    motoY = -800;
    coche2Y = -800;
    haycamion = true;
  }
  
  if(haycamion == true) // cuando se está en la fase del camión (haycamion)
  {
    velocidadA = velocidadB + 1; //la velocidad de los adornos se aproxima a la de los barriles, para que sea más realista
    if(camionX > width-400) // el camión va apareciendo poco a poco por la derecha de la pantalla, hasta alcanzar su posición (que es width - 400)
    {
      camionX = camionX - 4;
      
    }
    
    if(camionX <= width-400) //entonces comienza a lanzar barriles
    {
      haybarril = true;
      if(subir) //el camión se desplaza hasta arriba hasta llegar al tope, y luego baja
    {
      camionY = camionY - velocidadCam;
      
      if(camionY < 0)
      {
        subir = false;
        bajar = true;
      }
    }
    if(bajar) // el camión se desplaza hacia abajo hasta llagar al tope, y luego sube
    {
      camionY = camionY + velocidadCam;
      
      if(camionY > (height-200))
      {
        bajar = false;
        subir = true;
      }
    }
      
    }
    
    if(haybarril) //cuando empieza a soltar barriles
    {
      if(finalbarril == true) // cuando el barril 1 llega al final
      {
        barrilX = width-400; //vuelve al principio
        barrilY = camionY+40; //y la altura es a la que se encuentre el camión en ese momento +40, así parece que el camión ha lanzado el barril
        finalbarril = false;
      }
       if(finalbarril == false) //si todavía no ha llegado al final
       {
         barrilX = barrilX - velocidadB; // se desplaza hacia la izquierda según su velocidad
         if(barrilX < 390) // cuando llega a determinada posición en pantalla, el camión suelta el segundo barril
         {
           haybarril2 = true; //suelta el sgundo barril haciendo de valor verdadero la variable haybarril2
         }
         image(barril, barrilX, barrilY, 90, 150); // aparece por pantalla el barril 1
         if(barrilX < -90) //cuando llega al final se suma un punto a la puntuación, y finalbarril se hace de valor verdadero
         {
           puntuacion = puntuacion + 1;
           finalbarril = true;
         }
       }
    if(haybarril2) //el mismo código de antes pero para el segundo barril, una vez que haybarril2 se hace de valor verdadero
    {
      if(finalbarril2 == true)
       { 
        barril2X = width-400;
        barril2Y = camionY+40;
        finalbarril2 = false;
       }
       if(finalbarril2 == false)
       {
         barril2X = barril2X - velocidadB;
         image(barril2, barril2X, barril2Y, 90, 150);
         if(barril2X < -90)
         {
           puntuacion = puntuacion + 1;
           finalbarril2 = true;
         }
       }
    }
    }
    
    image(camion, camionX, camionY, 400, 280); // aparece por pantalla la imagen del camión
    
    
  }
  
  
  
   if(((abs(cocheY-coche2Y)<115 & abs(cocheX-coche2X)<160)) || (abs(cocheY-motoY)<90 & abs(cocheX-motoX)<160)) //si la distancia entre el coche rojo y el amarillo, o entre el coche rojo y la moto, es suficientemente pequeña (es decir, se chocan), hay una colisión y se acaba el juego
   {
    finjuego = true;
    chocar = true;
   }
   if(((((cocheY>barrilY) & ((abs(cocheY-barrilY))<150)) || ((cocheY<barrilY) & ((abs(cocheY-barrilY))<115))) & (abs(cocheX-barrilX)<160)) || (((cocheY>barril2Y) & (((abs(cocheY-barril2Y))<150)) || ((cocheY<barril2Y) & ((abs(cocheY-barril2Y))<115))) & (abs(cocheX-barril2X)<160))  ) //si la distancia entre el barril y el coche es lo suficientemente pequeña, (se chocan) hay una colisión y se acaba el juego
   {
    finjuego = true;
    chocar = true;
   }
   
   if(chocar) //tras haber habido una colisión, suena el sonido de choque
   {
     choque.trigger();
     chocar = false;
   }
   if(finjuego) //depués de haber sonado
   {
    //tanto el coche amarillo, como la moto, como el camion y los barriles, y los adornos se paran
    velocidadC = 0;
    velocidadM = 0;
    velocidadB = 0;
    velocidadCam = 0;
    velocidadA = 0;
    //el coche rojo se va de la pantalla por la izquierda
    cocheX = cocheX - 50;
    boom.resize(width,height);
    image(boom,0,0); // aparece una imagen de una explosión
    //aparece un mensaje de GAME OVER y la puntuación que se ha alcanzado, además de un mensaje que informa al usario de que haciendo click con el ratón puede volver a jugar y a echar otra partida
    textSize(50);
    fill(0);
    text("GAME OVER", width/2 - 130, height/2-60);
    text("Puntuación: "+ puntuacion, width/2 - 160, height/2);
    text("Haz click con el ratón para volver a jugar", width/2 - 450, height/2 +60);
    if(mousePressed) // al hacer click con el ratón, se para la música y se reestablencen los valores de las variables establecidas en void setup. De esta manera se reinicia el juego.
    {
      musica.stop();
      setup();
    }
    }
  

  }



}
