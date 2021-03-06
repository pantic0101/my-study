#include <stdio.h>
#include <stdlib.h>

#include <OpenGL/gl.h>
#include <OpenGL/glu.h>
#include <GLUT/glut.h>

#define POINTS 10000

typedef GLfloat point2[2];

void render(void);
void init(void);

int main(int argc, const char * argv[]) {
    glutInit(&argc, (char **) argv);
	glutInitDisplayMode (GLUT_SINGLE | GLUT_RGB);
	glutInitWindowSize(500, 500);
	glutInitWindowPosition(0, 0);
	glutCreateWindow("Sierpinski Gasket");
	glutDisplayFunc(render);
	init();
	glutMainLoop();
    return 0;
}

void render(void) {
    glClear(GL_COLOR_BUFFER_BIT);

    point2 p = { 75.0, 50.0 };
    point2 tri[3] = { {   0.0,   0.0 },
                      { 250.0, 500.0 },
                      { 500.0,   0.0 } };
    int i, n;

    for (i = 0; i < POINTS; i++) {
      n = rand() % 3;

      p[0] = (p[0] + tri[n][0]) / 2.0;
      p[1] = (p[1] + tri[n][1]) / 2.0;

      glBegin(GL_POINTS);
      glVertex2fv(p);
      glEnd();
    }

    glFlush();
}

void init(void) {
	glClearColor (1.0, 1.0, 1.0, 0.0);
    glColor3f(1.0, 0.0, 0.0);

    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluOrtho2D(0.0, 500.0, 0.0, 500.0);
    glMatrixMode(GL_MODELVIEW);
}
