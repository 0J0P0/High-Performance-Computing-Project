
c---------------------------------------------------------------------
c---------------------------------------------------------------------

      subroutine jacu(k, u, rho_i, qs, a, b, c, d, nx, nxmax, ny, nz)

c---------------------------------------------------------------------
c---------------------------------------------------------------------

c---------------------------------------------------------------------
c   compute the upper triangular part of the jacobian matrix
c---------------------------------------------------------------------


      implicit none

      include 'header.h'

c---------------------------------------------------------------------
c  input parameters
c---------------------------------------------------------------------
      integer k, nx, nxmax, ny, nz
      double precision u(5,nxmax,ny,nz), rho_i(nxmax,ny,nz), 
     $                 qs(nxmax,ny,nz),
     $                 a(5,5,2:nxmax-1,ny), b(5,5,2:nxmax-1,ny), 
     $                 c(5,5,2:nxmax-1,ny), d(5,5,2:nxmax-1,ny)

c---------------------------------------------------------------------
c  local variables
c---------------------------------------------------------------------
      integer i, j
      double precision  r43, c1345, c34, tmp1, tmp2, tmp3

      r43 = ( 4.0d0 / 3.0d0 )
      c1345 = c1 * c3 * c4 * c5
      c34 = c3 * c4

!$OMP DO SCHEDULE(RUNTIME)
         do j = ny-1, 2, -1
            do i = nx-1, 2, -1

c---------------------------------------------------------------------
c   form the block daigonal
c---------------------------------------------------------------------
               tmp1 = rho_i(i,j,k)
               tmp2 = tmp1 * tmp1
               tmp3 = tmp1 * tmp2

               d(1,1,i,j) =  1.0d0
     >                       + dt * 2.0d0 * (   tx1 * dx1
     >                                          + ty1 * dy1
     >                                          + tz1 * dz1 )
               d(1,2,i,j) =  0.0d0
               d(1,3,i,j) =  0.0d0
               d(1,4,i,j) =  0.0d0
               d(1,5,i,j) =  0.0d0

               d(2,1,i,j) =  dt * 2.0d0
     >           * ( - tx1 * r43 - ty1 - tz1 )
     >           * ( c34 * tmp2 * u(2,i,j,k) )
               d(2,2,i,j) =  1.0d0
     >          + dt * 2.0d0 * c34 * tmp1 
     >          * (  tx1 * r43 + ty1 + tz1 )
     >          + dt * 2.0d0 * (   tx1 * dx2
     >                             + ty1 * dy2
     >                             + tz1 * dz2  )
               d(2,3,i,j) = 0.0d0
               d(2,4,i,j) = 0.0d0
               d(2,5,i,j) = 0.0d0

               d(3,1,i,j) = dt * 2.0d0
     >           * ( - tx1 - ty1 * r43 - tz1 )
     >           * ( c34 * tmp2 * u(3,i,j,k) )
               d(3,2,i,j) = 0.0d0
               d(3,3,i,j) = 1.0d0
     >         + dt * 2.0d0 * c34 * tmp1
     >              * (  tx1 + ty1 * r43 + tz1 )
     >         + dt * 2.0d0 * (  tx1 * dx3
     >                           + ty1 * dy3
     >                           + tz1 * dz3 )
               d(3,4,i,j) = 0.0d0
               d(3,5,i,j) = 0.0d0

               d(4,1,i,j) = dt * 2.0d0
     >           * ( - tx1 - ty1 - tz1 * r43 )
     >           * ( c34 * tmp2 * u(4,i,j,k) )
               d(4,2,i,j) = 0.0d0
               d(4,3,i,j) = 0.0d0
               d(4,4,i,j) = 1.0d0
     >         + dt * 2.0d0 * c34 * tmp1
     >              * (  tx1 + ty1 + tz1 * r43 )
     >         + dt * 2.0d0 * (  tx1 * dx4
     >                           + ty1 * dy4
     >                           + tz1 * dz4 )
               d(4,5,i,j) = 0.0d0

               d(5,1,i,j) = -dt * 2.0d0
     >  * ( ( ( tx1 * ( r43*c34 - c1345 )
     >     + ty1 * ( c34 - c1345 )
     >     + tz1 * ( c34 - c1345 ) ) * ( u(2,i,j,k) ** 2 )
     >   + ( tx1 * ( c34 - c1345 )
     >     + ty1 * ( r43*c34 - c1345 )
     >     + tz1 * ( c34 - c1345 ) ) * ( u(3,i,j,k) ** 2 )
     >   + ( tx1 * ( c34 - c1345 )
     >     + ty1 * ( c34 - c1345 )
     >     + tz1 * ( r43*c34 - c1345 ) ) * ( u(4,i,j,k) ** 2 )
     >      ) * tmp3
     >   + ( tx1 + ty1 + tz1 ) * c1345 * tmp2 * u(5,i,j,k) )

               d(5,2,i,j) = dt * 2.0d0
     > * ( tx1 * ( r43*c34 - c1345 )
     >   + ty1 * (     c34 - c1345 )
     >   + tz1 * (     c34 - c1345 ) ) * tmp2 * u(2,i,j,k)
               d(5,3,i,j) = dt * 2.0d0
     > * ( tx1 * ( c34 - c1345 )
     >   + ty1 * ( r43*c34 -c1345 )
     >   + tz1 * ( c34 - c1345 ) ) * tmp2 * u(3,i,j,k)
               d(5,4,i,j) = dt * 2.0d0
     > * ( tx1 * ( c34 - c1345 )
     >   + ty1 * ( c34 - c1345 )
     >   + tz1 * ( r43*c34 - c1345 ) ) * tmp2 * u(4,i,j,k)
               d(5,5,i,j) = 1.0d0
     >   + dt * 2.0d0 * ( tx1 + ty1 + tz1 ) * c1345 * tmp1
     >   + dt * 2.0d0 * (  tx1 * dx5
     >                    +  ty1 * dy5
     >                    +  tz1 * dz5 )

c---------------------------------------------------------------------
c   form the first block sub-diagonal
c---------------------------------------------------------------------
               tmp1 = rho_i(i+1,j,k)
               tmp2 = tmp1 * tmp1
               tmp3 = tmp1 * tmp2

               a(1,1,i,j) = - dt * tx1 * dx1
               a(1,2,i,j) =   dt * tx2
               a(1,3,i,j) =   0.0d0
               a(1,4,i,j) =   0.0d0
               a(1,5,i,j) =   0.0d0

               a(2,1,i,j) =  dt * tx2
     >          * ( - ( u(2,i+1,j,k) * tmp1 ) ** 2
     >     + c2 * qs(i+1,j,k) * tmp1 )
     >          - dt * tx1 * ( - r43 * c34 * tmp2 * u(2,i+1,j,k) )
               a(2,2,i,j) =  dt * tx2
     >          * ( ( 2.0d0 - c2 ) * ( u(2,i+1,j,k) * tmp1 ) )
     >          - dt * tx1 * ( r43 * c34 * tmp1 )
     >          - dt * tx1 * dx2
               a(2,3,i,j) =  dt * tx2
     >              * ( - c2 * ( u(3,i+1,j,k) * tmp1 ) )
               a(2,4,i,j) =  dt * tx2
     >              * ( - c2 * ( u(4,i+1,j,k) * tmp1 ) )
               a(2,5,i,j) =  dt * tx2 * c2 

               a(3,1,i,j) =  dt * tx2
     >              * ( - ( u(2,i+1,j,k) * u(3,i+1,j,k) ) * tmp2 )
     >         - dt * tx1 * ( - c34 * tmp2 * u(3,i+1,j,k) )
               a(3,2,i,j) =  dt * tx2 * ( u(3,i+1,j,k) * tmp1 )
               a(3,3,i,j) =  dt * tx2 * ( u(2,i+1,j,k) * tmp1 )
     >          - dt * tx1 * ( c34 * tmp1 )
     >          - dt * tx1 * dx3
               a(3,4,i,j) = 0.0d0
               a(3,5,i,j) = 0.0d0

               a(4,1,i,j) = dt * tx2
     >          * ( - ( u(2,i+1,j,k)*u(4,i+1,j,k) ) * tmp2 )
     >          - dt * tx1 * ( - c34 * tmp2 * u(4,i+1,j,k) )
               a(4,2,i,j) = dt * tx2 * ( u(4,i+1,j,k) * tmp1 )
               a(4,3,i,j) = 0.0d0
               a(4,4,i,j) = dt * tx2 * ( u(2,i+1,j,k) * tmp1 )
     >          - dt * tx1 * ( c34 * tmp1 )
     >          - dt * tx1 * dx4
               a(4,5,i,j) = 0.0d0

               a(5,1,i,j) = dt * tx2
     >          * ( ( c2 * 2.0d0 * qs(i+1,j,k)
     >              - c1 * u(5,i+1,j,k) )
     >          * ( u(2,i+1,j,k) * tmp2 ) )
     >          - dt * tx1
     >          * ( - ( r43*c34 - c1345 ) * tmp3 * ( u(2,i+1,j,k)**2 )
     >              - (     c34 - c1345 ) * tmp3 * ( u(3,i+1,j,k)**2 )
     >              - (     c34 - c1345 ) * tmp3 * ( u(4,i+1,j,k)**2 )
     >              - c1345 * tmp2 * u(5,i+1,j,k) )
               a(5,2,i,j) = dt * tx2
     >          * ( c1 * ( u(5,i+1,j,k) * tmp1 )
     >             - c2
     >             * (  u(2,i+1,j,k)*u(2,i+1,j,k) * tmp2
     >                  + qs(i+1,j,k) * tmp1 ) )
     >           - dt * tx1
     >           * ( r43*c34 - c1345 ) * tmp2 * u(2,i+1,j,k)
               a(5,3,i,j) = dt * tx2
     >           * ( - c2 * ( u(3,i+1,j,k)*u(2,i+1,j,k) ) * tmp2 )
     >           - dt * tx1
     >           * (  c34 - c1345 ) * tmp2 * u(3,i+1,j,k)
               a(5,4,i,j) = dt * tx2
     >           * ( - c2 * ( u(4,i+1,j,k)*u(2,i+1,j,k) ) * tmp2 )
     >           - dt * tx1
     >           * (  c34 - c1345 ) * tmp2 * u(4,i+1,j,k)
               a(5,5,i,j) = dt * tx2
     >           * ( c1 * ( u(2,i+1,j,k) * tmp1 ) )
     >           - dt * tx1 * c1345 * tmp1
     >           - dt * tx1 * dx5

c---------------------------------------------------------------------
c   form the second block sub-diagonal
c---------------------------------------------------------------------
               tmp1 = rho_i(i,j+1,k)
               tmp2 = tmp1 * tmp1
               tmp3 = tmp1 * tmp2

               b(1,1,i,j) = - dt * ty1 * dy1
               b(1,2,i,j) =   0.0d0
               b(1,3,i,j) =  dt * ty2
               b(1,4,i,j) =   0.0d0
               b(1,5,i,j) =   0.0d0

               b(2,1,i,j) =  dt * ty2
     >           * ( - ( u(2,i,j+1,k)*u(3,i,j+1,k) ) * tmp2 )
     >           - dt * ty1 * ( - c34 * tmp2 * u(2,i,j+1,k) )
               b(2,2,i,j) =  dt * ty2 * ( u(3,i,j+1,k) * tmp1 )
     >          - dt * ty1 * ( c34 * tmp1 )
     >          - dt * ty1 * dy2
               b(2,3,i,j) =  dt * ty2 * ( u(2,i,j+1,k) * tmp1 )
               b(2,4,i,j) = 0.0d0
               b(2,5,i,j) = 0.0d0

               b(3,1,i,j) =  dt * ty2
     >           * ( - ( u(3,i,j+1,k) * tmp1 ) ** 2
     >      + c2 * ( qs(i,j+1,k) * tmp1 ) )
     >       - dt * ty1 * ( - r43 * c34 * tmp2 * u(3,i,j+1,k) )
               b(3,2,i,j) =  dt * ty2
     >                   * ( - c2 * ( u(2,i,j+1,k) * tmp1 ) )
               b(3,3,i,j) =  dt * ty2 * ( ( 2.0d0 - c2 )
     >                   * ( u(3,i,j+1,k) * tmp1 ) )
     >       - dt * ty1 * ( r43 * c34 * tmp1 )
     >       - dt * ty1 * dy3
               b(3,4,i,j) =  dt * ty2
     >                   * ( - c2 * ( u(4,i,j+1,k) * tmp1 ) )
               b(3,5,i,j) =  dt * ty2 * c2

               b(4,1,i,j) =  dt * ty2
     >              * ( - ( u(3,i,j+1,k)*u(4,i,j+1,k) ) * tmp2 )
     >       - dt * ty1 * ( - c34 * tmp2 * u(4,i,j+1,k) )
               b(4,2,i,j) = 0.0d0
               b(4,3,i,j) =  dt * ty2 * ( u(4,i,j+1,k) * tmp1 )
               b(4,4,i,j) =  dt * ty2 * ( u(3,i,j+1,k) * tmp1 )
     >                        - dt * ty1 * ( c34 * tmp1 )
     >                        - dt * ty1 * dy4
               b(4,5,i,j) = 0.0d0

               b(5,1,i,j) =  dt * ty2
     >          * ( ( c2 * 2.0d0 * qs(i,j+1,k)
     >               - c1 * u(5,i,j+1,k) )
     >          * ( u(3,i,j+1,k) * tmp2 ) )
     >          - dt * ty1
     >          * ( - (     c34 - c1345 )*tmp3*(u(2,i,j+1,k)**2)
     >              - ( r43*c34 - c1345 )*tmp3*(u(3,i,j+1,k)**2)
     >              - (     c34 - c1345 )*tmp3*(u(4,i,j+1,k)**2)
     >              - c1345*tmp2*u(5,i,j+1,k) )
               b(5,2,i,j) =  dt * ty2
     >          * ( - c2 * ( u(2,i,j+1,k)*u(3,i,j+1,k) ) * tmp2 )
     >          - dt * ty1
     >          * ( c34 - c1345 ) * tmp2 * u(2,i,j+1,k)
               b(5,3,i,j) =  dt * ty2
     >          * ( c1 * ( u(5,i,j+1,k) * tmp1 )
     >          - c2 
     >          * ( qs(i,j+1,k) * tmp1
     >               + u(3,i,j+1,k)*u(3,i,j+1,k) * tmp2 ) )
     >          - dt * ty1
     >          * ( r43*c34 - c1345 ) * tmp2 * u(3,i,j+1,k)
               b(5,4,i,j) =  dt * ty2
     >          * ( - c2 * ( u(3,i,j+1,k)*u(4,i,j+1,k) ) * tmp2 )
     >          - dt * ty1 * ( c34 - c1345 ) * tmp2 * u(4,i,j+1,k)
               b(5,5,i,j) =  dt * ty2
     >          * ( c1 * ( u(3,i,j+1,k) * tmp1 ) )
     >          - dt * ty1 * c1345 * tmp1
     >          - dt * ty1 * dy5

c---------------------------------------------------------------------
c   form the third block sub-diagonal
c---------------------------------------------------------------------
               tmp1 = rho_i(i,j,k+1)
               tmp2 = tmp1 * tmp1
               tmp3 = tmp1 * tmp2

               c(1,1,i,j) = - dt * tz1 * dz1
               c(1,2,i,j) =   0.0d0
               c(1,3,i,j) =   0.0d0
               c(1,4,i,j) = dt * tz2
               c(1,5,i,j) =   0.0d0

               c(2,1,i,j) = dt * tz2
     >           * ( - ( u(2,i,j,k+1)*u(4,i,j,k+1) ) * tmp2 )
     >           - dt * tz1 * ( - c34 * tmp2 * u(2,i,j,k+1) )
               c(2,2,i,j) = dt * tz2 * ( u(4,i,j,k+1) * tmp1 )
     >           - dt * tz1 * c34 * tmp1
     >           - dt * tz1 * dz2 
               c(2,3,i,j) = 0.0d0
               c(2,4,i,j) = dt * tz2 * ( u(2,i,j,k+1) * tmp1 )
               c(2,5,i,j) = 0.0d0

               c(3,1,i,j) = dt * tz2
     >           * ( - ( u(3,i,j,k+1)*u(4,i,j,k+1) ) * tmp2 )
     >           - dt * tz1 * ( - c34 * tmp2 * u(3,i,j,k+1) )
               c(3,2,i,j) = 0.0d0
               c(3,3,i,j) = dt * tz2 * ( u(4,i,j,k+1) * tmp1 )
     >           - dt * tz1 * ( c34 * tmp1 )
     >           - dt * tz1 * dz3
               c(3,4,i,j) = dt * tz2 * ( u(3,i,j,k+1) * tmp1 )
               c(3,5,i,j) = 0.0d0

               c(4,1,i,j) = dt * tz2
     >        * ( - ( u(4,i,j,k+1) * tmp1 ) ** 2
     >            + c2 * ( qs(i,j,k+1) * tmp1 ) )
     >        - dt * tz1 * ( - r43 * c34 * tmp2 * u(4,i,j,k+1) )
               c(4,2,i,j) = dt * tz2
     >             * ( - c2 * ( u(2,i,j,k+1) * tmp1 ) )
               c(4,3,i,j) = dt * tz2
     >             * ( - c2 * ( u(3,i,j,k+1) * tmp1 ) )
               c(4,4,i,j) = dt * tz2 * ( 2.0d0 - c2 )
     >             * ( u(4,i,j,k+1) * tmp1 )
     >             - dt * tz1 * ( r43 * c34 * tmp1 )
     >             - dt * tz1 * dz4
               c(4,5,i,j) = dt * tz2 * c2

               c(5,1,i,j) = dt * tz2
     >     * ( ( c2 * 2.0d0 * qs(i,j,k+1)
     >       - c1 * u(5,i,j,k+1) )
     >            * ( u(4,i,j,k+1) * tmp2 ) )
     >       - dt * tz1
     >       * ( - ( c34 - c1345 ) * tmp3 * (u(2,i,j,k+1)**2)
     >           - ( c34 - c1345 ) * tmp3 * (u(3,i,j,k+1)**2)
     >           - ( r43*c34 - c1345 )* tmp3 * (u(4,i,j,k+1)**2)
     >          - c1345 * tmp2 * u(5,i,j,k+1) )
               c(5,2,i,j) = dt * tz2
     >       * ( - c2 * ( u(2,i,j,k+1)*u(4,i,j,k+1) ) * tmp2 )
     >       - dt * tz1 * ( c34 - c1345 ) * tmp2 * u(2,i,j,k+1)
               c(5,3,i,j) = dt * tz2
     >       * ( - c2 * ( u(3,i,j,k+1)*u(4,i,j,k+1) ) * tmp2 )
     >       - dt * tz1 * ( c34 - c1345 ) * tmp2 * u(3,i,j,k+1)
               c(5,4,i,j) = dt * tz2
     >       * ( c1 * ( u(5,i,j,k+1) * tmp1 )
     >       - c2
     >       * ( qs(i,j,k+1) * tmp1
     >            + u(4,i,j,k+1)*u(4,i,j,k+1) * tmp2 ) )
     >       - dt * tz1 * ( r43*c34 - c1345 ) * tmp2 * u(4,i,j,k+1)
               c(5,5,i,j) = dt * tz2
     >       * ( c1 * ( u(4,i,j,k+1) * tmp1 ) )
     >       - dt * tz1 * c1345 * tmp1
     >       - dt * tz1 * dz5

            end do
         end do
!$OMP END DO nowait

      return
      end
