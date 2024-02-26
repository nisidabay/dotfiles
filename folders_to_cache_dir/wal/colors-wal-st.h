const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#0c0c0c", /* black   */
  [1] = "#6d685a", /* red     */
  [2] = "#78705f", /* green   */
  [3] = "#777464", /* yellow  */
  [4] = "#86816c", /* blue    */
  [5] = "#938c75", /* magenta */
  [6] = "#8b907c", /* cyan    */
  [7] = "#858585", /* white   */

  /* 8 bright colors */
  [8]  = "#484848",  /* black   */
  [9]  = "#928B78",  /* red     */
  [10] = "#A0967F", /* green   */
  [11] = "#9F9B86", /* yellow  */
  [12] = "#B3AC91", /* blue    */
  [13] = "#C4BB9D", /* magenta */
  [14] = "#BAC0A6", /* cyan    */
  [15] = "#c2c2c2", /* white   */

  /* special colors */
  [256] = "#0c0c0c", /* background */
  [257] = "#c2c2c2", /* foreground */
  [258] = "#c2c2c2",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
