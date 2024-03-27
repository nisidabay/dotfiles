const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#050507", /* black   */
  [1] = "#3e4236", /* red     */
  [2] = "#943b21", /* green   */
  [3] = "#446557", /* yellow  */
  [4] = "#9f773f", /* blue    */
  [5] = "#155466", /* magenta */
  [6] = "#1b7675", /* cyan    */
  [7] = "#828283", /* white   */

  /* 8 bright colors */
  [8]  = "#434345",  /* black   */
  [9]  = "#535848",  /* red     */
  [10] = "#C64F2D", /* green   */
  [11] = "#5B8774", /* yellow  */
  [12] = "#D59F55", /* blue    */
  [13] = "#1D7188", /* magenta */
  [14] = "#259E9D", /* cyan    */
  [15] = "#c0c0c1", /* white   */

  /* special colors */
  [256] = "#050507", /* background */
  [257] = "#c0c0c1", /* foreground */
  [258] = "#c0c0c1",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
