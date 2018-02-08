clear variables;
close all;

H = tf(conv([1, -9 + 9i], [1, -9 - 9i]), conv([1, 0], [1, 10]));

figure(1);

subplot(2, 2, 1);
rlocus(H);
axis([-11 11 -11 11]);
axis equal;

Gcl_rl = feedback(0.14606 * H, 1);

[A, B, C, D] = tf2ss(conv([1, -9 + 9i], [1, -9 - 9i]),...
                     conv([1, 0], [1, 10]));
rho = 1;
Klqr = lqr(A, B, C' * C, rho);
Gcl_ss = ss(A - B * Klqr, B, C, D);

%figure(2);
subplot(2, 2, 3);

pzmap(Gcl_rl);
title('Closed-loop Poles (Root Locus)');
axis equal;

%figure(3);
subplot(2, 2, 4);

pzmap(Gcl_ss);
title('Closed-loop Poles (LQR)');
axis equal;

%figure(4);
subplot(2, 2, 2);

h = stepplot(Gcl_rl, Gcl_ss);
setoptions(h, 'Normalize', 'on');
legend('Root Locus', 'LQR');
title('Step Responses');
